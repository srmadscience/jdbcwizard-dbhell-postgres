package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import ie.rolfe.dbhell.postgres.testkit.DbFixture;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * Helpers for numeric write tests. Each binding test writes the value 7
 * through a distinct JDBC setter and asserts the column round-trips.
 * 7 is deliberately tiny so it fits every target type including {@code byte}.
 *
 * Each call stages its own single-column table via {@link BindProbe}, so a
 * type the server can't store fails in isolation rather than poisoning the
 * whole suite.
 */
final class NumericBindingFixture {

    private NumericBindingFixture() { }

    interface Reader {
        Number read(ResultSet rs, String column) throws SQLException;
    }

    static void bindAndCheck(String colDdl, DbFixture.Binder binder, Reader reader, Number expected) {
        BindProbe.bindAndCheck(colDdl, binder,
            rs -> reader.read(rs, BindProbe.COLUMN),
            (e, a) -> assertEquals(0,
                new BigDecimal(e.toString()).compareTo(new BigDecimal(a.toString())),
                () -> "expected " + e + " but got " + a),
            expected);
    }
}
