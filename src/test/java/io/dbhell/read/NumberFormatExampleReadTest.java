package io.dbhell.read;

import io.dbhell.testkit.DbFixture;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Statement;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

/** Read tests for {@code dbhell.numberformat_example}. */
@DisplayName("dbhell.numberformat_example — read")
class NumberFormatExampleReadTest {

    @Test @DisplayName("name readable as String")
    void name() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT name FROM dbhell.numberformat_example WHERE name = '1,000'")) {
                DbFixture.assertOneRow(rs);
                assertEquals("1,000", rs.getString("name"));
            }
        });
    }

    @Test @DisplayName("money_value readable as String")
    void moneyValue() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT money_value FROM dbhell.numberformat_example WHERE name = '1,000'")) {
                DbFixture.assertOneRow(rs);
                assertEquals("$1,000.00", rs.getString("money_value"));
            }
        });
    }

    @Test @DisplayName("numberdata readable as BigDecimal")
    void numberdata() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT numberdata FROM dbhell.numberformat_example WHERE name = '1,000,000.976'")) {
                DbFixture.assertOneRow(rs);
                assertNotNull(rs.getBigDecimal("numberdata"));
                assertEquals(0, new BigDecimal("1000000.976").compareTo(rs.getBigDecimal("numberdata")));
            }
        });
    }

    @Test @DisplayName("null row stores SQL NULL in numberdata")
    void nullRow() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT numberdata FROM dbhell.numberformat_example WHERE name IS NULL")) {
                DbFixture.assertOneRow(rs);
                assertNull(rs.getBigDecimal("numberdata"));
                assertTrue(rs.wasNull());
            }
        });
    }
}
