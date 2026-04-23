package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.DbFixture;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGobject;

import static org.junit.jupiter.api.Assertions.assertEquals;

/** Bit-string columns. */
@DisplayName("scalar_zoo — write (bit strings)")
class ScalarZooBitsWriteTest {

    @Test @DisplayName("bits_fixed via PGobject('bit')")
    void bitsFixed() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "bits_fixed", (ps, i) -> {
                PGobject o = new PGobject();
                o.setType("bit");
                o.setValue("10101010");
                ps.setObject(i, o);
            });
            assertEquals("10101010",
                DbFixture.readScalar(c, "bits_fixed", rs -> rs.getString("bits_fixed")));
        });
    }

    @Test @DisplayName("bits_varying via PGobject('varbit')")
    void bitsVarying() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "bits_varying", (ps, i) -> {
                PGobject o = new PGobject();
                o.setType("varbit");
                o.setValue("1011");
                ps.setObject(i, o);
            });
            assertEquals("1011",
                DbFixture.readScalar(c, "bits_varying", rs -> rs.getString("bits_varying")));
        });
    }
}
