package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import ie.rolfe.dbhell.postgres.testkit.DbConfig;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;

import static org.junit.jupiter.api.Assertions.fail;

@DisplayName("BigDecimal -> double precision (server-side cast)")
class BigDecimalToDoubleTest {

    private static final String DDL = "double precision";

    private static void check(BigDecimal value) {
        BindProbe.<Double>bindAndCheck(
            DDL,
            (ps, i) -> ps.setBigDecimal(i, value),
            rs -> rs.getDouble(BindProbe.COLUMN),
            Double.valueOf(value.doubleValue()));
    }

    @Test @DisplayName("zero")
    void zero() { check(new BigDecimal("0")); }

    @Test @DisplayName("exact (7.5)")
    void exactRepresentable() { check(new BigDecimal("7.5")); }

    @Test @DisplayName("non-rep (0.1)")
    void nonRepresentable() { check(new BigDecimal("0.1")); }

    @Test @DisplayName("high precision")
    void highPrecision() { check(new BigDecimal("3.14159265358979323846264338327950288")); }

    @Test @DisplayName("negative")
    void negative() { check(new BigDecimal("-12345.6789")); }

    @Test @DisplayName("very large 1e100")
    void veryLarge() { check(new BigDecimal("1e100")); }

    @Test @DisplayName("very small 1e-100")
    void verySmall() { check(new BigDecimal("1e-100")); }

    @Test @DisplayName("1000 seeded random BigDecimals -> double")
    void randomThousand() throws Exception {
        final long seed = 0xC0FFEEL;
        final int n = 1000;
        Random rnd = new Random(seed);

        BigDecimal[] inputs = new BigDecimal[n];
        for (int i = 0; i < n; i++) inputs[i] = randomBigDecimal(rnd);

        double[] actual = new double[n];
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
                        actual[id] = rs.getDouble(2);
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
}
