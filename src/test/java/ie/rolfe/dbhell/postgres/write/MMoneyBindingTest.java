package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGobject;

import static org.junit.jupiter.api.Assertions.assertNotNull;

/** money — JDBC bindings. */
@DisplayName("money — JDBC bindings")
class MMoneyBindingTest {

    private static final String DDL = "money";

    @Test @DisplayName("setObject(PGobject('money'))")
    void setObjectPGobject() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> {
                PGobject o = new PGobject();
                o.setType("money");
                o.setValue("1234.56");
                ps.setObject(i, o);
            },
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertNotNull(a), null);
    }

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, "1234.56"),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertNotNull(a), null);
    }
}
