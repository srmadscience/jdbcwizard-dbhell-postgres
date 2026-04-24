package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGobject;

import static org.junit.jupiter.api.Assertions.assertTrue;

/** numrange — JDBC bindings. */
@DisplayName("numrange — JDBC bindings")
class RangeNumBindingTest {

    private static final String DDL = "numrange";
    private static final String INPUT = "[1.5,9.5)";

    @Test @DisplayName("setObject(PGobject('numrange'))")
    void setObjectPgObject() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> {
                PGobject o = new PGobject();
                o.setType("numrange");
                o.setValue(INPUT);
                ps.setObject(i, o);
            },
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertTrue(a != null && a.startsWith("[")), null);
    }

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, INPUT),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertTrue(a != null && a.startsWith("[")), null);
    }
}
