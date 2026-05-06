package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

@DisplayName("BigDecimal -> double precision (server-side cast)")
class BigDecimalToDoubleTest {

    private static final String DDL = "double precision";

    private static void check(BigDecimal value) {
        BindProbe.<Double>bindAndCheck(
            DDL,
            (ps, i) -> ps.setBigDecimal(i, value),
            rs -> rs.getDouble(BindProbe.COLUMN),
            Double.valueOf(value.doubleValue()));
    }

    @Test @DisplayName("zero")
    void zero() { check(new BigDecimal("0")); }

    @Test @DisplayName("exact (7.5)")
    void exactRepresentable() { check(new BigDecimal("7.5")); }

    @Test @DisplayName("non-rep (0.1)")
    void nonRepresentable() { check(new BigDecimal("0.1")); }

    @Test @DisplayName("high precision")
    void highPrecision() { check(new BigDecimal("3.14159265358979323846264338327950288")); }

    @Test @DisplayName("negative")
    void negative() { check(new BigDecimal("-12345.6789")); }

    @Test @DisplayName("very large 1e100")
    void veryLarge() { check(new BigDecimal("1e100")); }

    @Test @DisplayName("very small 1e-100")
    void verySmall() { check(new BigDecimal("1e-100")); }
}
