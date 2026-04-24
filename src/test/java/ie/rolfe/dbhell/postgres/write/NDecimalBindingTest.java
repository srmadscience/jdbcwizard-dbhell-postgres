package ie.rolfe.dbhell.postgres.write;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static ie.rolfe.dbhell.postgres.write.NumericBindingFixture.bindAndCheck;

/** decimal(20,6): one @Test per JDBC numeric binding. */
@DisplayName("decimal(20,6) — JDBC bindings")
class NDecimalBindingTest {

    private static final String DDL = "decimal(20, 6)";
    private static final Number EXPECT = new BigDecimal("7");

    @Test @DisplayName("setByte")
    void setByte() {
        bindAndCheck(DDL, (ps, i) -> ps.setByte(i, (byte) 7),
            (rs, c) -> rs.getBigDecimal(c), EXPECT);
    }

    @Test @DisplayName("setShort")
    void setShort() {
        bindAndCheck(DDL, (ps, i) -> ps.setShort(i, (short) 7),
            (rs, c) -> rs.getBigDecimal(c), EXPECT);
    }

    @Test @DisplayName("setInt")
    void setInt() {
        bindAndCheck(DDL, (ps, i) -> ps.setInt(i, 7),
            (rs, c) -> rs.getBigDecimal(c), EXPECT);
    }

    @Test @DisplayName("setLong")
    void setLong() {
        bindAndCheck(DDL, (ps, i) -> ps.setLong(i, 7L),
            (rs, c) -> rs.getBigDecimal(c), EXPECT);
    }

    @Test @DisplayName("setFloat")
    void setFloat() {
        bindAndCheck(DDL, (ps, i) -> ps.setFloat(i, 7.0f),
            (rs, c) -> rs.getBigDecimal(c), EXPECT);
    }

    @Test @DisplayName("setDouble")
    void setDouble() {
        bindAndCheck(DDL, (ps, i) -> ps.setDouble(i, 7.0),
            (rs, c) -> rs.getBigDecimal(c), EXPECT);
    }

    @Test @DisplayName("setBigDecimal")
    void setBigDecimal() {
        bindAndCheck(DDL, (ps, i) -> ps.setBigDecimal(i, new BigDecimal("7")),
            (rs, c) -> rs.getBigDecimal(c), EXPECT);
    }

    @Test @DisplayName("setString")
    void setString() {
        bindAndCheck(DDL, (ps, i) -> ps.setString(i, "7"),
            (rs, c) -> rs.getBigDecimal(c), EXPECT);
    }

    @Test @DisplayName("setObject(Integer)")
    void setObjectInteger() {
        bindAndCheck(DDL, (ps, i) -> ps.setObject(i, Integer.valueOf(7)),
            (rs, c) -> rs.getBigDecimal(c), EXPECT);
    }
}
