package io.dbhell.read;

import io.dbhell.testkit.DbFixture;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.Statement;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * Read tests for {@code dbhell.all_normal_datatypes}. Seed rows are created
 * by {@code Sql/pg/03_core_datatypes.sql} — the first row ('all null') has
 * only {@code name} populated; the second row ('42') has every column
 * populated with a sentinel value.
 */
@DisplayName("dbhell.all_normal_datatypes — read")
class AllNormalDatatypesReadTest {

    private static final String ALL_NULL = "all null";
    private static final String SENTINEL = "42";

    private static final BigDecimal BIG_38 =
        new BigDecimal("99999999999999999999999999999999999999");

    @Test @DisplayName("name is readable as String")
    void name() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT name FROM dbhell.all_normal_datatypes WHERE name = '" + ALL_NULL + "'")) {
                DbFixture.assertOneRow(rs);
                assertEquals(ALL_NULL, rs.getString("name"));
            }
        });
    }

    @Test @DisplayName("name_char is null in the all-null row")
    void nameCharNull() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT name_char FROM dbhell.all_normal_datatypes WHERE name = '" + ALL_NULL + "'")) {
                DbFixture.assertOneRow(rs);
                assertNull(rs.getString("name_char"));
                assertTrue(rs.wasNull());
            }
        });
    }

    @Test @DisplayName("name_char in sentinel row is padded to 2000 chars")
    void nameCharPadded() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT name_char FROM dbhell.all_normal_datatypes WHERE name = '" + SENTINEL + "'")) {
                DbFixture.assertOneRow(rs);
                String v = rs.getString("name_char");
                assertNotNull(v);
                assertEquals(2000, v.length());
                assertTrue(v.startsWith(SENTINEL));
            }
        });
    }

    @Test @DisplayName("seqno readable as BigDecimal")
    void seqno() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT seqno FROM dbhell.all_normal_datatypes WHERE name = '" + SENTINEL + "'")) {
                DbFixture.assertOneRow(rs);
                assertEquals(0, BIG_38.compareTo(rs.getBigDecimal("seqno")));
            }
        });
    }

    @Test @DisplayName("seqno_big readable as BigDecimal")
    void seqnoBig() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT seqno_big FROM dbhell.all_normal_datatypes WHERE name = '" + SENTINEL + "'")) {
                DbFixture.assertOneRow(rs);
                assertEquals(0, BIG_38.compareTo(rs.getBigDecimal("seqno_big")));
            }
        });
    }

    @Test @DisplayName("seqno_small = 42")
    void seqnoSmall() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT seqno_small FROM dbhell.all_normal_datatypes WHERE name = '" + SENTINEL + "'")) {
                DbFixture.assertOneRow(rs);
                assertEquals(42, rs.getInt("seqno_small"));
            }
        });
    }

    @Test @DisplayName("seqno_float = 42.0")
    void seqnoFloat() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT seqno_float FROM dbhell.all_normal_datatypes WHERE name = '" + SENTINEL + "'")) {
                DbFixture.assertOneRow(rs);
                assertEquals(42.0, rs.getDouble("seqno_float"), 1e-9);
            }
        });
    }

    @Test @DisplayName("date_generic populated in sentinel row")
    void dateGeneric() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT date_generic FROM dbhell.all_normal_datatypes WHERE name = '" + SENTINEL + "'")) {
                DbFixture.assertOneRow(rs);
                assertNotNull(rs.getDate("date_generic"));
                assertFalse(rs.wasNull());
            }
        });
    }

    @Test @DisplayName("date_generic null in all-null row")
    void dateGenericNull() {
        DbFixture.withRollback(c -> {
            try (Statement s = c.createStatement();
                 ResultSet rs = s.executeQuery(
                     "SELECT date_generic FROM dbhell.all_normal_datatypes WHERE name = '" + ALL_NULL + "'")) {
                DbFixture.assertOneRow(rs);
                assertNull(rs.getDate("date_generic"));
                assertTrue(rs.wasNull());
            }
        });
    }
}
