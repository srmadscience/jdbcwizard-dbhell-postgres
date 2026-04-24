package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGobject;

import static org.junit.jupiter.api.Assertions.assertTrue;

/** int4multirange — JDBC bindings. */
@DisplayName("int4multirange — JDBC bindings")
class MultirangeIntBindingTest {

    private static final String DDL = "int4multirange";
    private static final String INPUT = "{[1,5),[10,15)}";

    @Test @DisplayName("setObject(PGobject('int4multirange'))")
    void setObjectPgObject() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> {
                PGobject o = new PGobject();
                o.setType("int4multirange");
                o.setValue(INPUT);
                ps.setObject(i, o);
            },
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertTrue(a != null && a.contains("[1,5)")), null);
    }

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, INPUT),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertTrue(a != null && a.contains("[1,5)")), null);
    }
}
