package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.io.StringReader;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

/** char(10) — JDBC string bindings. The server blank-pads to width 10. */
@DisplayName("char(10) — JDBC bindings")
class SCharBindingTest {

    private static final String DDL = "char(10)";
    private static final String INPUT = "xy";

    private static void assertPaddedXy(String v) {
        assertTrue(v != null && v.startsWith(INPUT),
            () -> "expected blank-padded value starting with 'xy', got " + v);
        assertEquals(10, v.length(), () -> "expected length 10, got " + v.length());
    }

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, INPUT),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertPaddedXy(a), null);
    }

    @Test @DisplayName("setObject(String)")
    void setObjectString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setObject(i, INPUT),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertPaddedXy(a), null);
    }

    @Test @DisplayName("setCharacterStream")
    void setCharacterStream() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setCharacterStream(i, new StringReader(INPUT), INPUT.length()),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertPaddedXy(a), null);
    }
}
