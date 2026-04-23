package ie.rolfe.dbhell.postgres.read;

import ie.rolfe.dbhell.postgres.testkit.DbFixture;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.sql.ResultSet;
import java.sql.Statement;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

/** Read tests for {@code dbhell.boolean_test}. */
@DisplayName("dbhell.boolean_test — read")
class BooleanTestReadTest {

    @Test @DisplayName("name readable as String")
    void name() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT DISTINCT name FROM dbhell.boolean_test WHERE name IS NOT NULL ORDER BY name")) {
                DbFixture.assertOneRow(rs);
                assertEquals("FALSE", rs.getString("name"));
            }
        });
    }

    @Test @DisplayName("the_character_value = 'Y' exists as TRUE")
    void charValue() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT the_character_value FROM dbhell.boolean_test WHERE the_character_value = 'Y'")) {
                DbFixture.assertOneRow(rs);
                assertEquals("Y", rs.getString("the_character_value"));
            }
        });
    }

    @Test @DisplayName("the_number_value readable as double")
    void numberValue() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT the_number_value FROM dbhell.boolean_test WHERE the_character_value = 'tRue'")) {
                DbFixture.assertOneRow(rs);
                assertEquals(0.00000001, rs.getDouble("the_number_value"), 1e-12);
            }
        });
    }

    @Test @DisplayName("the_native_bool = true for TRUE rows")
    void nativeBoolTrue() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT the_native_bool FROM dbhell.boolean_test "
                   + "WHERE name = 'TRUE' AND the_character_value = 'Y'")) {
                DbFixture.assertOneRow(rs);
                assertTrue(rs.getBoolean("the_native_bool"));
            }
        });
    }

    @Test @DisplayName("the_native_bool null for the all-null row")
    void nativeBoolNull() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT the_native_bool FROM dbhell.boolean_test WHERE name = 'null'")) {
                DbFixture.assertOneRow(rs);
                rs.getBoolean("the_native_bool");
                assertTrue(rs.wasNull());
                // Re-read via Object to be absolutely sure.
                assertNull(rs.getObject("the_native_bool"));
            }
        });
    }
}
