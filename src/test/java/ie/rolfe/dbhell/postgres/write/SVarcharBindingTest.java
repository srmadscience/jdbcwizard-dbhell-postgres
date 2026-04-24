package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.io.StringReader;

/** varchar(100) — JDBC string bindings. */
@DisplayName("varchar(100) — JDBC bindings")
class SVarcharBindingTest {

    private static final String DDL = "varchar(100)";
    private static final String EXPECT = "abcde";

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
