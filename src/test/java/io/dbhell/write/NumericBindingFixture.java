package io.dbhell.write;

import io.dbhell.testkit.DbFixture;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * Helpers for numeric write tests. Each binding test writes the value 7
 * through a distinct JDBC setter and asserts the column round-trips.
 * 7 is deliberately tiny so it fits every target type including {@code byte}.
 */
final class NumericBindingFixture {

    private NumericBindingFixture() { }

    interface Reader {
        Number read(ResultSet rs, String column) throws SQLException;
    }

    static void bindAndCheck(String column, DbFixture.Binder binder, Reader reader, Number expected) {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, column, binder);
            Number actual = DbFixture.readScalar(c, column, rs -> reader.read(rs, column));
            // BigDecimal vs double vs int all need different equality; compare via BigDecimal.
            assertEquals(0, new BigDecimal(expected.toString())
                              .compareTo(new BigDecimal(actual.toString())),
                () -> "expected " + expected + " but got " + actual);
        });
    }
}
