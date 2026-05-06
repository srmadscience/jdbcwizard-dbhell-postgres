package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import ie.rolfe.dbhell.postgres.testkit.DbConfig;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.junit.jupiter.api.Assertions.fail;

/**
 * BigDecimal round-trip against a {@code numeric(7,2)} column.
 *
 * The (7,2) shape is chosen so it works on both Postgres and CrateDB —
 * CrateDB requires precision/scale on stored NUMERIC columns.
 */
@DisplayName("numeric(7,2) — BigDecimal write & update")
class Numeric72BigDecimalTest {

    private static final String DDL = "numeric(7, 2)";

    @Test @DisplayName("setBigDecimal inserts an exact (7,2) value")
    void insertExact() {
        BigDecimal value = new BigDecimal("12345.67");
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setBigDecimal(i, value),
            rs -> rs.getBigDecimal(BindProbe.COLUMN),
            (e, a) -> assertEquals(0, e.compareTo(a),
                () -> "expected " + e + " but got " + a),
            value);
    }

    @Test @DisplayName("setBigDecimal rounds to scale=2 on insert")
    void insertRoundsToScale() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setBigDecimal(i, new BigDecimal("1.005")),
            rs -> rs.getBigDecimal(BindProbe.COLUMN),
            (e, a) -> assertEquals(0, e.compareTo(a),
                () -> "expected " + e + " but got " + a),
            new BigDecimal("1.01"));
    }

    @Test @DisplayName("UPDATE … SET col = ? via setBigDecimal round-trips")
    void updateRoundTrip() throws SQLException, InterruptedException {
        BigDecimal initial  = new BigDecimal("100.00");
        BigDecimal replaced = new BigDecimal("9999.99");

        try (Connection c = DbConfig.open()) {
            c.setAutoCommit(true);
            createTable(c);
            try {
                insert(c, initial);
                Thread.sleep(2_000L);
                update(c, replaced);
                Thread.sleep(2_000L);

                BigDecimal actual = readSingle(c);
                assertEquals(0, replaced.compareTo(actual),
                    () -> "expected " + replaced + " but got " + actual);
            } finally {
                drop(c);
            }
        }
    }

    private static void createTable(Connection c) throws SQLException {
        try (Statement s = c.createStatement()) {
            s.execute("DROP TABLE IF EXISTS " + BindProbe.TABLE);
            s.execute("CREATE TABLE " + BindProbe.TABLE
                + " (" + BindProbe.COLUMN + " " + DDL + ")");
        }
    }

    private static void drop(Connection c) throws SQLException {
        try (Statement s = c.createStatement()) {
            s.execute("DROP TABLE IF EXISTS " + BindProbe.TABLE);
        }
    }

    private static void insert(Connection c, BigDecimal v) throws SQLException {
        try (PreparedStatement ps = c.prepareStatement(
                "INSERT INTO " + BindProbe.TABLE
                + " (" + BindProbe.COLUMN + ") VALUES (?)")) {
            ps.setBigDecimal(1, v);
            int n = ps.executeUpdate();
            if (n != 1) {
                throw new AssertionError("expected 1 row inserted, got " + n);
            }
        }
    }

    private static void update(Connection c, BigDecimal v) throws SQLException {
        try (PreparedStatement ps = c.prepareStatement(
                "UPDATE " + BindProbe.TABLE
                + " SET " + BindProbe.COLUMN + " = ?")) {
            ps.setBigDecimal(1, v);
            int n = ps.executeUpdate();
            if (n != 1) {
                throw new AssertionError("expected 1 row updated, got " + n);
            }
        }
    }

    @Test @DisplayName("1000 seeded random BigDecimals into numeric(7,2)")
    void randomThousand() throws Exception {
        final long seed = 0xC0FFEEL;
        final int n = 1000;
        Random rnd = new Random(seed);

        BigDecimal[] inputs = new BigDecimal[n];
        for (int i = 0; i < n; i++) inputs[i] = randomNumericProbe(rnd);

        BigDecimal[] actual = new BigDecimal[n];
        boolean[] seen = new boolean[n];
        String[] insertError = new String[n];

        try (Connection c = DbConfig.open()) {
            c.setAutoCommit(true);
            try (Statement s = c.createStatement()) {
                s.execute("DROP TABLE IF EXISTS " + BindProbe.TABLE);
                s.execute("CREATE TABLE " + BindProbe.TABLE
                    + " (id int, " + BindProbe.COLUMN + " " + DDL + ")");
            }
            try {
                try (PreparedStatement ps = c.prepareStatement(
                        "INSERT INTO " + BindProbe.TABLE
                            + " (id, " + BindProbe.COLUMN + ") VALUES (?, ?)")) {
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
                Thread.sleep(2_000L);
                try (PreparedStatement ps = c.prepareStatement(
                        "SELECT id, " + BindProbe.COLUMN + " FROM " + BindProbe.TABLE);
                     ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        int id = rs.getInt(1);
                        actual[id] = rs.getBigDecimal(2);
                        seen[id] = true;
                    }
                }
            } finally {
                try (Statement s = c.createStatement()) {
                    s.execute("DROP TABLE IF EXISTS " + BindProbe.TABLE);
                }
            }
        }

        StringBuilder problems = new StringBuilder();
        int rejected = 0, mismatched = 0, unexpectedRejection = 0;
        BigDecimal limit = new BigDecimal("100000");
        for (int i = 0; i < n; i++) {
            BigDecimal expected = inputs[i].setScale(2, RoundingMode.HALF_UP);
            boolean shouldFit = expected.abs().compareTo(limit) < 0;
            if (insertError[i] != null) {
                rejected++;
                if (shouldFit) {
                    unexpectedRejection++;
                    if (rejected + mismatched <= 20) {
                        problems.append(String.format(
                            "%n  [%d] UNEXPECTED-REJECT in=%s rounded=%s err=%s",
                            i, inputs[i].toPlainString(),
                            expected.toPlainString(), insertError[i]));
                    }
                }
                continue;
            }
            if (!shouldFit) {
                mismatched++;
                if (rejected + mismatched <= 20) {
                    problems.append(String.format(
                        "%n  [%d] EXPECTED-OVERFLOW-ACCEPTED in=%s rounded=%s stored=%s",
                        i, inputs[i].toPlainString(),
                        expected.toPlainString(),
                        seen[i] ? actual[i].toPlainString() : "<missing>"));
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
            if (expected.compareTo(actual[i]) != 0) {
                mismatched++;
                if (rejected + mismatched <= 20) {
                    problems.append(String.format(
                        "%n  [%d] MISMATCH in=%s expected=%s actual=%s",
                        i, inputs[i].toPlainString(),
                        expected.toPlainString(), actual[i].toPlainString()));
                }
            }
        }
        if (unexpectedRejection + mismatched > 0) {
            fail("rejected=" + rejected
                + " unexpectedRejections=" + unexpectedRejection
                + " mismatched=" + mismatched
                + " of " + n + " (showing up to 20)" + problems);
        }
    }

    private static BigDecimal randomNumericProbe(Random rnd) {
        int bits = 1 + rnd.nextInt(26);
        BigInteger unscaled = new BigInteger(bits, rnd);
        if (rnd.nextBoolean()) unscaled = unscaled.negate();
        int scale = rnd.nextInt(7);
        return new BigDecimal(unscaled, scale);
    }

    private static BigDecimal readSingle(Connection c) throws SQLException {
        try (PreparedStatement ps = c.prepareStatement(
                "SELECT " + BindProbe.COLUMN + " FROM " + BindProbe.TABLE);
             ResultSet rs = ps.executeQuery()) {
            assertTrue(rs.next(), "no row returned from " + BindProbe.TABLE);
            return rs.getBigDecimal(BindProbe.COLUMN);
        }
    }
}
