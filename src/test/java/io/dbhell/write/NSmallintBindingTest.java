package io.dbhell.write;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static io.dbhell.write.NumericBindingFixture.bindAndCheck;

/** n_smallint: one @Test per JDBC numeric binding. */
@DisplayName("scalar_zoo.n_smallint — JDBC bindings")
class NSmallintBindingTest {

    private static final String COL = "n_smallint";
    private static final Number EXPECT = 7;

    @Test @DisplayName("setByte")
    void setByte() {
        bindAndCheck(COL, (ps, i) -> ps.setByte(i, (byte) 7), (rs, c) -> rs.getShort(c), EXPECT);
    }

    @Test @DisplayName("setShort")
    void setShort() {
        bindAndCheck(COL, (ps, i) -> ps.setShort(i, (short) 7), (rs, c) -> rs.getShort(c), EXPECT);
    }

    @Test @DisplayName("setInt")
    void setInt() {
        bindAndCheck(COL, (ps, i) -> ps.setInt(i, 7), (rs, c) -> rs.getShort(c), EXPECT);
    }

    @Test @DisplayName("setLong")
    void setLong() {
        bindAndCheck(COL, (ps, i) -> ps.setLong(i, 7L), (rs, c) -> rs.getShort(c), EXPECT);
    }

    @Test @DisplayName("setFloat")
    void setFloat() {
        bindAndCheck(COL, (ps, i) -> ps.setFloat(i, 7.0f), (rs, c) -> rs.getShort(c), EXPECT);
    }

    @Test @DisplayName("setDouble")
    void setDouble() {
        bindAndCheck(COL, (ps, i) -> ps.setDouble(i, 7.0), (rs, c) -> rs.getShort(c), EXPECT);
    }

    @Test @DisplayName("setBigDecimal")
    void setBigDecimal() {
        bindAndCheck(COL, (ps, i) -> ps.setBigDecimal(i, new BigDecimal("7")),
            (rs, c) -> rs.getShort(c), EXPECT);
    }

    @Test @DisplayName("setString")
    void setString() {
        bindAndCheck(COL, (ps, i) -> ps.setString(i, "7"), (rs, c) -> rs.getShort(c), EXPECT);
    }
}
