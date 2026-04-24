package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.sql.Time;
import java.time.LocalTime;

/** time — JDBC temporal bindings. */
@DisplayName("time — JDBC bindings")
class DTimeBindingTest {

    private static final String DDL = "time";
    private static final Time EXPECT = Time.valueOf("12:34:56");

    @Test @DisplayName("setTime")
    void setTime() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setTime(i, EXPECT),
            rs -> rs.getTime(BindProbe.COLUMN), EXPECT);
    }

    @Test @DisplayName("setObject(LocalTime)")
    void setObjectLocalTime() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setObject(i, LocalTime.of(12, 34, 56)),
            rs -> rs.getTime(BindProbe.COLUMN), EXPECT);
    }

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, "12:34:56"),
            rs -> rs.getTime(BindProbe.COLUMN), EXPECT);
    }
}
