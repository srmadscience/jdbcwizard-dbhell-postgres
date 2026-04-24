package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGInterval;

import static org.junit.jupiter.api.Assertions.assertEquals;

/** interval year to month — JDBC bindings. */
@DisplayName("interval year to month — JDBC bindings")
class DIntvYmBindingTest {

    private static final String DDL = "interval year to month";

    @Test @DisplayName("setObject(PGInterval)")
    void setObjectPgInterval() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setObject(i, new PGInterval(2, 3, 0, 0, 0, 0)),
            rs -> (PGInterval) rs.getObject(BindProbe.COLUMN),
            (e, a) -> {
                assertEquals(2, a.getYears());
                assertEquals(3, a.getMonths());
            }, null);
    }

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setString(i, "2 years 3 months"),
            rs -> (PGInterval) rs.getObject(BindProbe.COLUMN),
            (e, a) -> {
                assertEquals(2, a.getYears());
                assertEquals(3, a.getMonths());
            }, null);
    }
}
