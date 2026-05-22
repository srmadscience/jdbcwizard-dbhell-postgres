package cratedb;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;

import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

/**
 * Standalone reproducer for two BigDecimal -> double precision bugs observed on
 * CrateDB 6.2.4 (verified with PostgreSQL JDBC driver 42.7.4):
 *
 *   1. Positive-scale BigDecimals (very small numbers whose toPlainString()
 *      contains many leading zeros) are rejected at insert with
 *      "Character array is missing 'e' notation exponential mark."
 *   2. Negative-scale BigDecimals (very large numbers) are stored with their
 *      scale silently dropped — the unscaled mantissa survives but the
 *      exponent does not.
 *
 * Neither failure occurs on PostgreSQL 18, so the two targeted tests
 * intentionally pass on the buggy CrateDB build and fail on Postgres — they
 * are tripwires that will flip when CrateDB fixes the wire-format parser.
 *
 * Connection settings come from env vars; defaults target a local CrateDB.
 */
class CrateDbBigDecimalDoubleReproTest {

    private static final String URL = System.getenv().getOrDefault(
        "PG_URL",
        "jdbc:postgresql://localhost:5432/crate?stringtype=unspecified");
    private static final String USER = System.getenv().getOrDefault("PG_USER", "crate");
    private static final String PASSWORD = System.getenv().getOrDefault("PG_PASSWORD", "");

    private static final String TABLE  = "bigdecimal_repro";
    private static final String COLUMN = "the_value";

    private static final long READ_AFTER_WRITE_DELAY_MS = 2_000L;

    private static Connection open() throws SQLException {
        Connection c = DriverManager.getConnection(URL, USER, PASSWORD);
        c.setAutoCommit(true);
        return c;
    }

    @BeforeAll
    static void createTable() throws SQLException {
        try (Connection c = open(); Statement s = c.createStatement()) {
            s.execute("DROP TABLE IF EXISTS " + TABLE);
            s.execute("CREATE TABLE " + TABLE
                + " (id int, " + COLUMN + " double precision)");
        }
    }

    @AfterAll
    static void dropTable() throws SQLException {
        try (Connection c = open(); Statement s = c.createStatement()) {
            s.execute("DROP TABLE IF EXISTS " + TABLE);
        }
    }

    @Test
    @DisplayName("positive-scale BigDecimal is rejected with 'missing e notation'")
    void positiveScaleRejected() throws Exception {
        // 190487833519 * 10^-32  ≈ 1.9e-21
        // toPlainString() -> "0.0000000000000000000019048783351900..."
        // CrateDB's protocol parser refuses this shape and demands 'e' notation.
        BigDecimal value = new BigDecimal(BigInteger.valueOf(190_487_833_519L), 32);

        SQLException caught = null;
        try (Connection c = open()) {
            deleteAll(c);
            try (PreparedStatement ps = c.prepareStatement(
                    "INSERT INTO " + TABLE + " (id, " + COLUMN + ") VALUES (?, ?)")) {
                ps.setInt(1, 1);
                ps.setBigDecimal(2, value);
                ps.executeUpdate();
            } catch (SQLException ex) {
                caught = ex;
            }
        }

        assertNotNull(caught,
            "expected CrateDB to reject positive-scale BigDecimal with a wire-format error, "
            + "but the insert succeeded — has the bug been fixed?");
        String msg = caught.getMessage() == null ? "" : caught.getMessage();
        assertTrue(msg.toLowerCase().contains("notation")
                || msg.toLowerCase().contains("exponential"),
            "expected error mentioning 'e' notation / exponential, got: " + msg);
    }

    @Test
    @DisplayName("negative-scale BigDecimal is silently stored without its exponent")
    void negativeScaleSilentlyTruncated() throws Exception {
        // 2_051_888 * 10^36 = 2.051888e42
        BigDecimal value = new BigDecimal(BigInteger.valueOf(2_051_888L), -36);
        double expected = value.doubleValue();

        Double actual;
        try (Connection c = open()) {
            deleteAll(c);
            try (PreparedStatement ps = c.prepareStatement(
                    "INSERT INTO " + TABLE + " (id, " + COLUMN + ") VALUES (?, ?)")) {
                ps.setInt(1, 1);
                ps.setBigDecimal(2, value);
                ps.executeUpdate();
            }
            Thread.sleep(READ_AFTER_WRITE_DELAY_MS);
            actual = readOne(c);
        }

        assertNotNull(actual, "row was not stored at all — different failure mode than expected");
        assertNotEquals(
            0, Double.compare(expected, actual),
            "expected CrateDB to silently truncate the exponent (stored=2051888.0, "
            + "expected=2.051888E42) but the value round-tripped — has the bug been fixed?");
    }

    @Test
    @DisplayName("1000 seeded random BigDecimals — same seed as CRATEDB_MATRIX.md")
    void randomThousand() throws Exception {
        final long seed = 0xC0FFEEL;
        final int n = 1000;
        Random rnd = new Random(seed);

        BigDecimal[] inputs = new BigDecimal[n];
        for (int i = 0; i < n; i++) inputs[i] = randomBigDecimal(rnd);

        double[] actual = new double[n];
        boolean[] seen = new boolean[n];
        String[] insertError = new String[n];

        try (Connection c = open()) {
            deleteAll(c);
            try (PreparedStatement ps = c.prepareStatement(
                    "INSERT INTO " + TABLE + " (id, " + COLUMN + ") VALUES (?, ?)")) {
                for (int i = 0; i < n; i++) {
                    try {
                        ps.setInt(1, i);
                        ps.setBigDecimal(2, inputs[i]);
                        ps.executeUpdate();
                    } catch (SQLException ex) {
                        insertError[i] = ex.getMessage();
                    }
                }
            }
            Thread.sleep(READ_AFTER_WRITE_DELAY_MS);
            try (PreparedStatement ps = c.prepareStatement(
                    "SELECT id, " + COLUMN + " FROM " + TABLE);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt(1);
                    actual[id] = rs.getDouble(2);
                    seen[id] = true;
                }
            }
        }

        StringBuilder problems = new StringBuilder();
        int rejected = 0, mismatched = 0;
        for (int i = 0; i < n; i++) {
            if (insertError[i] != null) {
                rejected++;
                if (rejected + mismatched <= 20) {
                    problems.append(String.format(
                        "%n  [%d] REJECTED in=%s err=%s",
                        i, inputs[i].toPlainString(), insertError[i]));
                }
                continue;
            }
            if (!seen[i]) {
                mismatched++;
                if (rejected + mismatched <= 20) {
                    problems.append(String.format(
                        "%n  [%d] MISSING in=%s", i, inputs[i].toPlainString()));
                }
                continue;
            }
            double expected = inputs[i].doubleValue();
            if (Double.compare(expected, actual[i]) != 0) {
                mismatched++;
                if (rejected + mismatched <= 20) {
                    problems.append(String.format(
                        "%n  [%d] MISMATCH in=%s scale=%d expected=%s actual=%s",
                        i, inputs[i].toPlainString(), inputs[i].scale(),
                        expected, actual[i]));
                }
            }
        }
        if (rejected + mismatched > 0) {
            fail("rejected=" + rejected + " mismatched=" + mismatched
                + " of " + n + " (showing up to 20)" + problems);
        }
    }

    private static BigDecimal randomBigDecimal(Random rnd) {
        int bits = 1 + rnd.nextInt(80);
        BigInteger unscaled = new BigInteger(bits, rnd);
        if (rnd.nextBoolean()) unscaled = unscaled.negate();
        int scale = rnd.nextInt(601) - 300;
        return new BigDecimal(unscaled, scale);
    }

    private static void deleteAll(Connection c) throws SQLException {
        try (Statement s = c.createStatement()) {
            s.execute("DELETE FROM " + TABLE);
        }
    }

    private static Double readOne(Connection c) throws SQLException {
        try (PreparedStatement ps = c.prepareStatement(
                "SELECT " + COLUMN + " FROM " + TABLE);
             ResultSet rs = ps.executeQuery()) {
            if (!rs.next()) return null;
            double v = rs.getDouble(1);
            return rs.wasNull() ? null : v;
        }
    }
}
