package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.io.StringReader;

/** text — JDBC string bindings. */
@DisplayName("text — JDBC bindings")
class STextBindingTest {

    private static final String DDL = "text";
    private static final String EXPECT = "hello";

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, EXPECT),
            rs -> rs.getString(BindProbe.COLUMN), EXPECT);
    }

    @Test @DisplayName("setObject(String)")
    void setObjectString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setObject(i, EXPECT),
            rs -> rs.getString(BindProbe.COLUMN), EXPECT);
    }

    @Test @DisplayName("setCharacterStream")
    void setCharacterStream() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setCharacterStream(i, new StringReader(EXPECT), EXPECT.length()),
            rs -> rs.getString(BindProbe.COLUMN), EXPECT);
    }
}
