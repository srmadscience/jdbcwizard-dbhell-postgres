package ie.rolfe.dbhell.postgres.testkit;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * JDBC connection config. Overridable via environment variables so the suite
 * can run against any Postgres 18 instance; defaults match the Postgres.app
 * setup used during development.
 */
public final class DbConfig {

    // stringtype=unspecified lets the server infer the target type of values
    // sent via setString(). Without it, a setString("7") bound to a numeric
    // column fails with "column is of type X but expression is of type
    // character varying" — which would defeat the setString numeric-binding
    // tests. Keep this setting on the test connection; a real application may
    // prefer the default.
    public static final String URL =
        System.getenv().getOrDefault("PG_URL",
            "jdbc:postgresql://localhost:5432/pg_dbhell_test?stringtype=unspecified");

    public static final String USER =
        System.getenv().getOrDefault("PG_USER", System.getProperty("user.name"));

    public static final String PASSWORD =
        System.getenv().getOrDefault("PG_PASSWORD", "");

    private DbConfig() { }

    public static Connection open() throws SQLException {
        Connection c = DriverManager.getConnection(URL, USER, PASSWORD);
        c.setAutoCommit(false);
        return c;
    }
}
