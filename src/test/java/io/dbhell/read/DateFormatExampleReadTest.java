package io.dbhell.read;

import io.dbhell.testkit.DbFixture;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

/** Read tests for {@code dbhell.dateformat_example}. */
@DisplayName("dbhell.dateformat_example — read")
class DateFormatExampleReadTest {

    @Test @DisplayName("name readable as String")
    void name() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT name FROM dbhell.dateformat_example WHERE name = 'midnight'")) {
                DbFixture.assertOneRow(rs);
                assertEquals("midnight", rs.getString("name"));
            }
        });
    }

    @Test @DisplayName("date_value for 'midnight' is 1967-11-06 00:00:00")
    void dateValueMidnight() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT date_value FROM dbhell.dateformat_example WHERE name = 'midnight'")) {
                DbFixture.assertOneRow(rs);
                Timestamp ts = rs.getTimestamp("date_value");
                assertNotNull(ts);
                assertEquals(Timestamp.valueOf("1967-11-06 00:00:00"), ts);
            }
        });
    }

    @Test @DisplayName("date_value for '3am' is 1967-11-06 03:00:00")
    void dateValueThreeAm() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT date_value FROM dbhell.dateformat_example WHERE name = '3am'")) {
                DbFixture.assertOneRow(rs);
                assertEquals(Timestamp.valueOf("1967-11-06 03:00:00"),
                             rs.getTimestamp("date_value"));
            }
        });
    }

    @Test @DisplayName("date_string readable as String")
    void dateString() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT date_string FROM dbhell.dateformat_example WHERE name = 'midnight'")) {
                DbFixture.assertOneRow(rs);
                assertEquals("1967/11/06", rs.getString("date_string"));
            }
        });
    }

    @Test @DisplayName("time_string readable as String")
    void timeString() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT time_string FROM dbhell.dateformat_example WHERE name = '3am'")) {
                DbFixture.assertOneRow(rs);
                assertEquals("03:00:00", rs.getString("time_string"));
            }
        });
    }
}
