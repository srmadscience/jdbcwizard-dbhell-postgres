package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.io.StringReader;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

/** bpchar(5) — JDBC string bindings. Blank-padded to width 5. */
@DisplayName("bpchar(5) — JDBC bindings")
class SBpcharBindingTest {

    private static final String DDL = "bpchar(5)";
    private static final String INPUT = "z";

    private static void assertPaddedZ(String v) {
        assertTrue(v != null && v.startsWith(INPUT),
            () -> "expected blank-padded value starting with 'z', got " + v);
        assertEquals(5, v.length(), () -> "expected length 5, got " + v.length());
    }

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, INPUT),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertPaddedZ(a), null);
    }

    @Test @DisplayName("setObject(String)")
    void setObjectString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setObject(i, INPUT),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertPaddedZ(a), null);
    }

    @Test @DisplayName("setCharacterStream")
    void setCharacterStream() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setCharacterStream(i, new StringReader(INPUT), INPUT.length()),
            rs -> rs.getString(BindProbe.COLUMN),
            (e, a) -> assertPaddedZ(a), null);
    }
}
