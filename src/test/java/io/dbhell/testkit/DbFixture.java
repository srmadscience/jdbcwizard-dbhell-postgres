package io.dbhell.testkit;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.function.Consumer;

import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * Helpers around {@link DbConfig#open}.
 * <p>
 * Tests run inside a connection that is rolled back at the end, so each
 * test sees the schema as it was loaded by {@code pg_dbhell.sql} and leaves
 * it that way.
 */
public final class DbFixture {

    private DbFixture() { }

    /** Opens a connection, runs the body, always rolls back and closes. */
    public static void withRollback(SqlConsumer<Connection> body) {
        try (Connection c = DbConfig.open()) {
            try {
                body.accept(c);
            } finally {
                c.rollback();
            }
        } catch (SQLException e) {
            throw new AssertionError("DB error: " + e.getMessage(), e);
        }
    }

    /** Inserts the {@code all null} row used by several read tests. */
    public static void assertOneRow(ResultSet rs) throws SQLException {
        assertTrue(rs.next(), "expected a row");
    }

    /** Inserts a single scalar into {@code dbhell.scalar_zoo} via the caller's binder. */
    public static void insertScalar(Connection c, String column, Binder binder) throws SQLException {
        String sql = "INSERT INTO dbhell.scalar_zoo (" + column + ") VALUES (?)";
        try (PreparedStatement ps = c.prepareStatement(sql)) {
            binder.bind(ps, 1);
            int n = ps.executeUpdate();
            if (n != 1) {
                throw new AssertionError("expected 1 row inserted, got " + n);
            }
        }
    }

    /** Reads a single scalar column value from {@code dbhell.scalar_zoo}. */
    public static <T> T readScalar(Connection c, String column, RsReader<T> reader) throws SQLException {
        String sql = "SELECT " + column + " FROM dbhell.scalar_zoo";
        try (PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            assertTrue(rs.next(), "no row returned from scalar_zoo");
            return reader.read(rs);
        }
    }

    @FunctionalInterface
    public interface SqlConsumer<T> {
        void accept(T t) throws SQLException;
    }

    @FunctionalInterface
    public interface Binder {
        void bind(PreparedStatement ps, int index) throws SQLException;
    }

    @FunctionalInterface
    public interface RsReader<T> {
        T read(ResultSet rs) throws SQLException;
    }
}
