package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGobject;

import static org.junit.jupiter.api.Assertions.assertEquals;

/** bit varying(64) — JDBC bindings. */
@DisplayName("bit varying(64) — JDBC bindings")
class BitsVaryingBindingTest {

    private static final String DDL = "bit varying(64)";
    private static final String EXPECT = "1011";

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, EXPECT),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertEquals(EXPECT, a), null);
    }

    @Test @DisplayName("setObject(PGobject('varbit'))")
    void setObjectPgObject() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> {
                PGobject o = new PGobject();
                o.setType("varbit");
                o.setValue(EXPECT);
                ps.setObject(i, o);
            },
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertEquals(EXPECT, a), null);
    }
}
