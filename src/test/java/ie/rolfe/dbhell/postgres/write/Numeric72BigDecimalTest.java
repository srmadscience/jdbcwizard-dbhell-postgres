package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import ie.rolfe.dbhell.postgres.testkit.DbConfig;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

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

    private static BigDecimal readSingle(Connection c) throws SQLException {
        try (PreparedStatement ps = c.prepareStatement(
                "SELECT " + BindProbe.COLUMN + " FROM " + BindProbe.TABLE);
             ResultSet rs = ps.executeQuery()) {
            assertTrue(rs.next(), "no row returned from " + BindProbe.TABLE);
            return rs.getBigDecimal(BindProbe.COLUMN);
        }
    }
}
