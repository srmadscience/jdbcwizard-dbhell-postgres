package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.sql.Timestamp;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;

import static org.junit.jupiter.api.Assertions.assertNotNull;

/**
 * timestamp with time zone — JDBC bindings.
 *
 * Note: pgjdbc cannot infer a SQL type for {@link java.time.Instant}, so it
 * is omitted here. Applications that need to bind an Instant must convert
 * it to an OffsetDateTime first.
 */
@DisplayName("timestamp with time zone — JDBC bindings")
class DTstzBindingTest {

    private static final String DDL = "timestamp with time zone";

    @Test @DisplayName("setTimestamp")
    void setTimestamp() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setTimestamp(i, Timestamp.valueOf("1967-11-06 12:34:56")),
            rs -> rs.getTimestamp(BindProbe.COLUMN),
            (e, a) -> assertNotNull(a), null);
    }

    @Test @DisplayName("setObject(OffsetDateTime)")
    void setObjectOffsetDateTime() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setObject(i,
                OffsetDateTime.of(1967, 11, 6, 12, 34, 56, 0, ZoneOffset.UTC)),
            rs -> rs.getTimestamp(BindProbe.COLUMN),
            (e, a) -> assertNotNull(a), null);
    }

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setString(i, "1967-11-06 12:34:56+00"),
            rs -> rs.getTimestamp(BindProbe.COLUMN),
            (e, a) -> assertNotNull(a), null);
    }
}
