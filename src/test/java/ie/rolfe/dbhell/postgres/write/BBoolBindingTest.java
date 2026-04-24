package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertTrue;

/** boolean — JDBC bindings. */
@DisplayName("boolean — JDBC bindings")
class BBoolBindingTest {

    private static final String DDL = "boolean";

    @Test @DisplayName("setBoolean")
    void setBoolean() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setBoolean(i, true),
            rs -> rs.getBoolean(BindProbe.COLUMN),
            (e, a) -> assertTrue(a), null);
    }

    @Test @DisplayName("setObject(Boolean)")
    void setObjectBoolean() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setObject(i, Boolean.TRUE),
            rs -> rs.getBoolean(BindProbe.COLUMN),
            (e, a) -> assertTrue(a), null);
    }

    @Test @DisplayName("setString(\"true\")")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, "true"),
            rs -> rs.getBoolean(BindProbe.COLUMN),
            (e, a) -> assertTrue(a), null);
    }
}
