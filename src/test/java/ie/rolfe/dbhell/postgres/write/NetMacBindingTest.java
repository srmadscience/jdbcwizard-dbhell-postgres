package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGobject;

import static org.junit.jupiter.api.Assertions.assertEquals;

/** macaddr — JDBC bindings. */
@DisplayName("macaddr — JDBC bindings")
class NetMacBindingTest {

    private static final String DDL = "macaddr";
    private static final String EXPECT = "08:00:2b:01:02:03";

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, EXPECT),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertEquals(EXPECT, a), null);
    }

    @Test @DisplayName("setObject(PGobject('macaddr'))")
    void setObjectPgObject() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> {
                PGobject o = new PGobject();
                o.setType("macaddr");
                o.setValue(EXPECT);
                ps.setObject(i, o);
            },
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertEquals(EXPECT, a), null);
    }
}
