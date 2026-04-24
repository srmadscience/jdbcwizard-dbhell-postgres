package ie.rolfe.dbhell.postgres.testkit;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * Single-column staging table used by binding tests.
 *
 * Each test class declares the column DDL it needs. {@link #bindAndCheck}
 * creates {@code dbhell.bind_probe (the_value <colDdl>)}, binds one row via
 * the caller's {@link DbFixture.Binder}, reads it back via the caller's
 * {@link DbFixture.RsReader}, and drops the table.
 *
 * Each call uses its own connection in autocommit mode (DDL cannot be rolled
 * back inside the test the way {@link DbFixture#withRollback} does for DML).
 * Failures still leave a clean schema because the drop runs in a finally.
 */
public final class BindProbe {

    public static final String TABLE = "dbhell.bind_probe";
    public static final String COLUMN = "the_value";

    private BindProbe() { }

    public static <T> void bindAndCheck(String colDdl,
                                        DbFixture.Binder binder,
                                        DbFixture.RsReader<T> reader,
                                        T expected) {
        bindAndCheck(colDdl, binder, reader,
            (e, a) -> assertEquals(e, a, () -> "expected " + e + " but got " + a),
            expected);
    }

    /**
     * Sleep between INSERT and SELECT, longer than CrateDB's default Lucene
     * refresh interval (1s) so that eventually-consistent reads see the row.
     * Postgres pays this cost too — the alternative is a CrateDB-aware
     * fixture, which is more code than the lost test seconds are worth.
     */
    private static final long READ_AFTER_WRITE_DELAY_MS = 2_000L;

    public static <T> void bindAndCheck(String colDdl,
                                        DbFixture.Binder binder,
                                        DbFixture.RsReader<T> reader,
                                        Asserter<T> asserter,
                                        T expected) {
        try (Connection c = DbConfig.open()) {
            c.setAutoCommit(true);
            create(c, colDdl);
            try {
                insert(c, binder);
                Thread.sleep(READ_AFTER_WRITE_DELAY_MS);
                T actual = read(c, reader);
                asserter.check(expected, actual);
            } finally {
                drop(c);
            }
        } catch (SQLException e) {
            throw new AssertionError("DB error: " + e.getMessage(), e);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            throw new AssertionError("interrupted while waiting for read-after-write", e);
        }
    }

    private static void create(Connection c, String colDdl) throws SQLException {
        try (Statement s = c.createStatement()) {
            s.execute("DROP TABLE IF EXISTS " + TABLE);
            s.execute("CREATE TABLE " + TABLE + " (" + COLUMN + " " + colDdl + ")");
        }
    }

    private static void drop(Connection c) throws SQLException {
        try (Statement s = c.createStatement()) {
            s.execute("DROP TABLE IF EXISTS " + TABLE);
        }
    }

    private static void insert(Connection c, DbFixture.Binder binder) throws SQLException {
        try (PreparedStatement ps = c.prepareStatement(
                "INSERT INTO " + TABLE + " (" + COLUMN + ") VALUES (?)")) {
            binder.bind(ps, 1);
            int n = ps.executeUpdate();
            if (n != 1) {
                throw new AssertionError("expected 1 row inserted, got " + n);
            }
        }
    }

    private static <T> T read(Connection c, DbFixture.RsReader<T> reader) throws SQLException {
        try (PreparedStatement ps = c.prepareStatement(
                "SELECT " + COLUMN + " FROM " + TABLE);
             ResultSet rs = ps.executeQuery()) {
            assertTrue(rs.next(), "no row returned from " + TABLE);
            return reader.read(rs);
        }
    }

    @FunctionalInterface
    public interface Asserter<T> {
        void check(T expected, T actual);
    }
}
