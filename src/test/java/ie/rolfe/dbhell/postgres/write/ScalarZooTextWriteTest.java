package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.DbFixture;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

/** Write tests for string-shaped columns of {@code dbhell.scalar_zoo}. */
@DisplayName("scalar_zoo — write (strings)")
class ScalarZooTextWriteTest {

    @Test @DisplayName("s_text via setString")
    void sText() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "s_text", (ps, i) -> ps.setString(i, "hello"));
            assertEquals("hello", DbFixture.readScalar(c, "s_text", rs -> rs.getString("s_text")));
        });
    }

    @Test @DisplayName("s_varchar via setString")
    void sVarchar() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "s_varchar", (ps, i) -> ps.setString(i, "abcde"));
            assertEquals("abcde", DbFixture.readScalar(c, "s_varchar", rs -> rs.getString("s_varchar")));
        });
    }

    @Test @DisplayName("s_char via setString (blank-padded to 10)")
    void sChar() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "s_char", (ps, i) -> ps.setString(i, "xy"));
            String v = DbFixture.readScalar(c, "s_char", rs -> rs.getString("s_char"));
            assertTrue(v.startsWith("xy"));
            assertEquals(10, v.length());
        });
    }

    @Test @DisplayName("s_bpchar via setString (blank-padded to 5)")
    void sBpchar() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "s_bpchar", (ps, i) -> ps.setString(i, "z"));
            String v = DbFixture.readScalar(c, "s_bpchar", rs -> rs.getString("s_bpchar"));
            assertEquals(5, v.length());
            assertTrue(v.startsWith("z"));
        });
    }
}
