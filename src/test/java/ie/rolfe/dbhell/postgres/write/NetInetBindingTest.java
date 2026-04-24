package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGobject;

import static org.junit.jupiter.api.Assertions.assertEquals;

/** inet — JDBC bindings. */
@DisplayName("inet — JDBC bindings")
class NetInetBindingTest {

    private static final String DDL = "inet";
    private static final String EXPECT = "192.168.0.1";

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, EXPECT),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertEquals(EXPECT, a), null);
    }

    @Test @DisplayName("setObject(PGobject('inet'))")
    void setObjectPgObject() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> {
                PGobject o = new PGobject();
                o.setType("inet");
                o.setValue(EXPECT);
                ps.setObject(i, o);
            },
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertEquals(EXPECT, a), null);
    }
}
