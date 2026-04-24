package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGobject;

import static org.junit.jupiter.api.Assertions.assertEquals;

/** cidr — JDBC bindings. */
@DisplayName("cidr — JDBC bindings")
class NetCidrBindingTest {

    private static final String DDL = "cidr";
    private static final String EXPECT = "192.168.0.0/24";

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, EXPECT),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertEquals(EXPECT, a), null);
    }

    @Test @DisplayName("setObject(PGobject('cidr'))")
    void setObjectPgObject() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> {
                PGobject o = new PGobject();
                o.setType("cidr");
                o.setValue(EXPECT);
                ps.setObject(i, o);
            },
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertEquals(EXPECT, a), null);
    }
}
