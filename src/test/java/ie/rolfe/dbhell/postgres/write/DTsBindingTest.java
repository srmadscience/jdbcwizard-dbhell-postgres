package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.sql.Timestamp;
import java.time.LocalDateTime;

/** timestamp (without time zone) — JDBC temporal bindings. */
@DisplayName("timestamp — JDBC bindings")
class DTsBindingTest {

    private static final String DDL = "timestamp";
    private static final Timestamp EXPECT = Timestamp.valueOf("1967-11-06 12:34:56");

    @Test @DisplayName("setTimestamp")
    void setTimestamp() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setTimestamp(i, EXPECT),
            rs -> rs.getTimestamp(BindProbe.COLUMN), EXPECT);
    }

    @Test @DisplayName("setObject(LocalDateTime)")
    void setObjectLocalDateTime() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setObject(i, LocalDateTime.of(1967, 11, 6, 12, 34, 56)),
            rs -> rs.getTimestamp(BindProbe.COLUMN), EXPECT);
    }

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, "1967-11-06 12:34:56"),
            rs -> rs.getTimestamp(BindProbe.COLUMN), EXPECT);
    }
}
