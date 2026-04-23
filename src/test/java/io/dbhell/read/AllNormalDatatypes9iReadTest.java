package io.dbhell.read;

import io.dbhell.testkit.DbFixture;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGInterval;

import java.sql.ResultSet;
import java.sql.Statement;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

/** Read tests for {@code dbhell.all_normal_datatypes_9i}. */
@DisplayName("dbhell.all_normal_datatypes_9i — read")
class AllNormalDatatypes9iReadTest {

    @Test @DisplayName("id is a positive identity value")
    void id() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT id FROM dbhell.all_normal_datatypes_9i ORDER BY id LIMIT 1")) {
                DbFixture.assertOneRow(rs);
                assertTrue(rs.getLong("id") > 0);
            }
        });
    }

    @Test @DisplayName("name readable as String")
    void name() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT name FROM dbhell.all_normal_datatypes_9i WHERE name = 'all null'")) {
                DbFixture.assertOneRow(rs);
                assertEquals("all null", rs.getString("name"));
            }
        });
    }

    @Test @DisplayName("date_generic is null in the all-null row")
    void dateGenericNull() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT date_generic FROM dbhell.all_normal_datatypes_9i WHERE name = 'all null'")) {
                DbFixture.assertOneRow(rs);
                assertNull(rs.getDate("date_generic"));
                assertTrue(rs.wasNull());
            }
        });
    }

    @Test @DisplayName("timestamp_generic populated when seeded")
    void timestampGeneric() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT timestamp_generic FROM dbhell.all_normal_datatypes_9i "
                   + "WHERE name = 'all null except timestamp'")) {
                DbFixture.assertOneRow(rs);
                assertNotNull(rs.getTimestamp("timestamp_generic"));
            }
        });
    }

    @Test @DisplayName("timestamp_tz populated when seeded")
    void timestampTz() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT timestamp_tz FROM dbhell.all_normal_datatypes_9i "
                   + "WHERE name = 'all null except timestamp_tz'")) {
                DbFixture.assertOneRow(rs);
                assertNotNull(rs.getTimestamp("timestamp_tz"));
            }
        });
    }

    @Test @DisplayName("timestamp_local_tz populated when seeded")
    void timestampLocalTz() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT timestamp_local_tz FROM dbhell.all_normal_datatypes_9i "
                   + "WHERE name = 'all null except timestamp_local_tz'")) {
                DbFixture.assertOneRow(rs);
                assertNotNull(rs.getTimestamp("timestamp_local_tz"));
            }
        });
    }

    @Test @DisplayName("date_year_2_month = 23 years 2 months")
    void yearToMonth() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT date_year_2_month FROM dbhell.all_normal_datatypes_9i WHERE name = 'dy2month'")) {
                DbFixture.assertOneRow(rs);
                PGInterval iv = (PGInterval) rs.getObject("date_year_2_month");
                assertNotNull(iv);
                assertEquals(23, iv.getYears());
                assertEquals(2,  iv.getMonths());
            }
        });
    }

    @Test @DisplayName("date_day_2_second = 11:12:10.222222")
    void dayToSecond() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT date_day_2_second FROM dbhell.all_normal_datatypes_9i WHERE name = 'dd2second'")) {
                DbFixture.assertOneRow(rs);
                PGInterval iv = (PGInterval) rs.getObject("date_day_2_second");
                assertNotNull(iv);
                assertEquals(11, iv.getHours());
                assertEquals(12, iv.getMinutes());
                assertEquals(10.222222, iv.getSeconds(), 1e-6);
            }
        });
    }

    @Test @DisplayName("a_rowid populated in 'all null except rowid' row")
    void rowid() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT a_rowid FROM dbhell.all_normal_datatypes_9i "
                   + "WHERE name = 'all null except rowid'")) {
                DbFixture.assertOneRow(rs);
                assertNotNull(rs.getString("a_rowid"));
            }
        });
    }

    @Test @DisplayName("a_u_rowid is null in the all-null row (text)")
    void uRowid() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT a_u_rowid FROM dbhell.all_normal_datatypes_9i WHERE name = 'all null'")) {
                DbFixture.assertOneRow(rs);
                assertNull(rs.getString("a_u_rowid"));
                assertTrue(rs.wasNull());
            }
        });
    }
}
