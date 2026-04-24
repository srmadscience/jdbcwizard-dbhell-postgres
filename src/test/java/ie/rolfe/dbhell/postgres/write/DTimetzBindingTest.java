package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.time.OffsetTime;
import java.time.ZoneOffset;

import static org.junit.jupiter.api.Assertions.assertNotNull;

/** time with time zone — JDBC temporal bindings. */
@DisplayName("time with time zone — JDBC bindings")
class DTimetzBindingTest {

    private static final String DDL = "time with time zone";

    @Test @DisplayName("setObject(OffsetTime)")
    void setObjectOffsetTime() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setObject(i, OffsetTime.of(12, 34, 56, 0, ZoneOffset.UTC)),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertNotNull(a), null);
    }

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, "12:34:56+00"),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertNotNull(a), null);
    }
}
