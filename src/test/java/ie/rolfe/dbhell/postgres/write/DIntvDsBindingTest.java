package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGInterval;

import static org.junit.jupiter.api.Assertions.assertEquals;

/** interval day to second — JDBC bindings. */
@DisplayName("interval day to second — JDBC bindings")
class DIntvDsBindingTest {

    private static final String DDL = "interval day to second";

    @Test @DisplayName("setObject(PGInterval)")
    void setObjectPgInterval() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setObject(i, new PGInterval(0, 0, 1, 2, 3, 4.0)),
            rs -> (PGInterval) rs.getObject(BindProbe.COLUMN),
            (e, a) -> {
                assertEquals(1, a.getDays());
                assertEquals(2, a.getHours());
            }, null);
    }

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setString(i, "1 day 2 hours 3 minutes"),
            rs -> (PGInterval) rs.getObject(BindProbe.COLUMN),
            (e, a) -> {
                assertEquals(1, a.getDays());
                assertEquals(2, a.getHours());
            }, null);
    }
}
