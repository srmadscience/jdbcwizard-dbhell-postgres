package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGobject;

import static org.junit.jupiter.api.Assertions.assertTrue;

/** tsrange — JDBC bindings. */
@DisplayName("tsrange — JDBC bindings")
class RangeTsBindingTest {

    private static final String DDL = "tsrange";
    private static final String INPUT = "[1967-11-06, 1970-01-01)";

    @Test @DisplayName("setObject(PGobject('tsrange'))")
    void setObjectPgObject() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> {
                PGobject o = new PGobject();
                o.setType("tsrange");
                o.setValue(INPUT);
                ps.setObject(i, o);
            },
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertTrue(a != null && a.contains("1967-11-06")), null);
    }

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, INPUT),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertTrue(a != null && a.contains("1967-11-06")), null);
    }
}
