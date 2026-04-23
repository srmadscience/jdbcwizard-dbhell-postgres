package io.dbhell.read;

import io.dbhell.testkit.DbFixture;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Statement;

import static org.junit.jupiter.api.Assertions.assertEquals;

/** Read tests for {@code dbhell.number_test}. */
@DisplayName("dbhell.number_test — read")
class NumberTestReadTest {

    @Test @DisplayName("name readable as String")
    void name() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT name FROM dbhell.number_test WHERE name = 'max_byte'")) {
                DbFixture.assertOneRow(rs);
                assertEquals("max_byte", rs.getString("name"));
            }
        });
    }

    @Test @DisplayName("the_value = 127 for max_byte")
    void maxByte() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT the_value FROM dbhell.number_test WHERE name = 'max_byte'")) {
                DbFixture.assertOneRow(rs);
                assertEquals(0, new BigDecimal("127").compareTo(rs.getBigDecimal("the_value")));
            }
        });
    }

    @Test @DisplayName("the_value = 128 for max_byte+1")
    void maxBytePlus1() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT the_value FROM dbhell.number_test WHERE name = 'max_byte+1'")) {
                DbFixture.assertOneRow(rs);
                assertEquals(0, new BigDecimal("128").compareTo(rs.getBigDecimal("the_value")));
            }
        });
    }

    @Test @DisplayName("the_value = 65535 for max_short")
    void maxShort() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT the_value FROM dbhell.number_test WHERE name = 'max_short'")) {
                DbFixture.assertOneRow(rs);
                assertEquals(0, new BigDecimal("65535").compareTo(rs.getBigDecimal("the_value")));
            }
        });
    }

    @Test @DisplayName("the_value = 65536 for max_short+1")
    void maxShortPlus1() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT the_value FROM dbhell.number_test WHERE name = 'max_short+1'")) {
                DbFixture.assertOneRow(rs);
                assertEquals(0, new BigDecimal("65536").compareTo(rs.getBigDecimal("the_value")));
            }
        });
    }
}
