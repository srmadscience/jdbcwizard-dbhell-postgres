package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;

/** date — JDBC temporal bindings. */
@DisplayName("date — JDBC bindings")
class DDateBindingTest {

    private static final String DDL = "date";
    private static final Date EXPECT = Date.valueOf("1967-11-06");

    @Test @DisplayName("setDate")
    void setDate() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setDate(i, EXPECT),
            rs -> rs.getDate(BindProbe.COLUMN), EXPECT);
    }

    @Test @DisplayName("setObject(LocalDate)")
    void setObjectLocalDate() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setObject(i, LocalDate.of(1967, 11, 6)),
            rs -> rs.getDate(BindProbe.COLUMN), EXPECT);
    }

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, "1967-11-06"),
            rs -> rs.getDate(BindProbe.COLUMN), EXPECT);
    }

    @Test @DisplayName("setTimestamp (truncated to date)")
    void setTimestamp() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setTimestamp(i, Timestamp.valueOf("1967-11-06 00:00:00")),
            rs -> rs.getDate(BindProbe.COLUMN), EXPECT);
    }
}
