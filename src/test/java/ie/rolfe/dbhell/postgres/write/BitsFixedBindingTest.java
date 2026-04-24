package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGobject;

import static org.junit.jupiter.api.Assertions.assertEquals;

/** bit(8) — JDBC bindings. */
@DisplayName("bit(8) — JDBC bindings")
class BitsFixedBindingTest {

    private static final String DDL = "bit(8)";
    private static final String EXPECT = "10101010";

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, EXPECT),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertEquals(EXPECT, a), null);
    }

    @Test @DisplayName("setObject(PGobject('bit'))")
    void setObjectPgObject() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> {
                PGobject o = new PGobject();
                o.setType("bit");
                o.setValue(EXPECT);
                ps.setObject(i, o);
            },
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertEquals(EXPECT, a), null);
    }
}
