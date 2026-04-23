package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.DbFixture;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGobject;

import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

/** bool / bytea / money / uuid columns. */
@DisplayName("scalar_zoo — write (bool, bytea, money, uuid)")
class ScalarZooMiscWriteTest {

    @Test @DisplayName("b_bool via setBoolean")
    void bBool() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "b_bool", (ps, i) -> ps.setBoolean(i, true));
            Boolean v = DbFixture.readScalar(c, "b_bool", rs -> rs.getBoolean("b_bool"));
            assertTrue(v);
        });
    }

    @Test @DisplayName("b_bytea via setBytes")
    void bBytea() {
        DbFixture.withRollback(c -> {
            byte[] expected = {0x6a, 0x6b, 0x6c};
            DbFixture.insertScalar(c, "b_bytea", (ps, i) -> ps.setBytes(i, expected));
            assertArrayEquals(expected,
                DbFixture.readScalar(c, "b_bytea", rs -> rs.getBytes("b_bytea")));
        });
    }

    @Test @DisplayName("m_money via setObject(PGobject('money'))")
    void mMoney() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "m_money", (ps, i) -> {
                PGobject o = new PGobject();
                o.setType("money");
                o.setValue("1234.56");
                ps.setObject(i, o);
            });
            assertNotNull(DbFixture.readScalar(c, "m_money", rs -> rs.getString("m_money")));
        });
    }

    @Test @DisplayName("u_uuid via setObject(UUID)")
    void uUuid() {
        UUID u = UUID.fromString("11111111-2222-3333-4444-555555555555");
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "u_uuid", (ps, i) -> ps.setObject(i, u));
            assertEquals(u, DbFixture.readScalar(c, "u_uuid",
                rs -> rs.getObject("u_uuid", UUID.class)));
        });
    }
}
