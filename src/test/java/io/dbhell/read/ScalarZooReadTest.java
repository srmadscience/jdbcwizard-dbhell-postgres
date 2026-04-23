package io.dbhell.read;

import io.dbhell.testkit.DbFixture;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGInterval;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * Read tests for every column in {@code dbhell.scalar_zoo}. The table is
 * empty in the seed data, so each test inserts a single-column row, selects
 * it back, and rolls back.
 */
@DisplayName("dbhell.scalar_zoo — read (round-trip)")
class ScalarZooReadTest {

    private static void roundTrip(String column, String literal,
                                  DbFixture.RsReader<Void> assertions) {
        DbFixture.withRollback(c -> {
            try (PreparedStatement ps = c.prepareStatement(
                    "INSERT INTO dbhell.scalar_zoo (" + column + ") VALUES (" + literal + ")")) {
                assertEquals(1, ps.executeUpdate());
            }
            try (PreparedStatement ps = c.prepareStatement(
                    "SELECT " + column + " FROM dbhell.scalar_zoo");
                 ResultSet rs = ps.executeQuery()) {
                DbFixture.assertOneRow(rs);
                assertions.read(rs);
            }
        });
    }

    // ---- numeric -----------------------------------------------------------

    @Test @DisplayName("n_smallint")
    void nSmallint() {
        roundTrip("n_smallint", "32000", rs -> {
            assertEquals((short) 32000, rs.getShort("n_smallint"));
            return null;
        });
    }

    @Test @DisplayName("n_int")
    void nInt() {
        roundTrip("n_int", "2000000000", rs -> {
            assertEquals(2_000_000_000, rs.getInt("n_int"));
            return null;
        });
    }

    @Test @DisplayName("n_bigint")
    void nBigint() {
        roundTrip("n_bigint", "9000000000000000000", rs -> {
            assertEquals(9_000_000_000_000_000_000L, rs.getLong("n_bigint"));
            return null;
        });
    }

    @Test @DisplayName("n_real")
    void nReal() {
        roundTrip("n_real", "1.5", rs -> {
            assertEquals(1.5f, rs.getFloat("n_real"), 1e-6);
            return null;
        });
    }

    @Test @DisplayName("n_double")
    void nDouble() {
        roundTrip("n_double", "3.1415926535", rs -> {
            assertEquals(3.1415926535, rs.getDouble("n_double"), 1e-12);
            return null;
        });
    }

    @Test @DisplayName("n_decimal")
    void nDecimal() {
        roundTrip("n_decimal", "12345.678901", rs -> {
            assertEquals(0, new BigDecimal("12345.678901")
                .compareTo(rs.getBigDecimal("n_decimal")));
            return null;
        });
    }

    // ---- strings -----------------------------------------------------------

    @Test @DisplayName("s_text")
    void sText() {
        roundTrip("s_text", "'unbounded text'", rs -> {
            assertEquals("unbounded text", rs.getString("s_text"));
            return null;
        });
    }

    @Test @DisplayName("s_varchar")
    void sVarchar() {
        roundTrip("s_varchar", "'varchar100'", rs -> {
            assertEquals("varchar100", rs.getString("s_varchar"));
            return null;
        });
    }

    @Test @DisplayName("s_char (blank-padded)")
    void sChar() {
        roundTrip("s_char", "'ab'", rs -> {
            String v = rs.getString("s_char");
            assertNotNull(v);
            assertEquals(10, v.length());
            assertTrue(v.startsWith("ab"));
            return null;
        });
    }

    @Test @DisplayName("s_bpchar (blank-padded, 5)")
    void sBpchar() {
        roundTrip("s_bpchar", "'ab'", rs -> {
            String v = rs.getString("s_bpchar");
            assertEquals(5, v.length());
            return null;
        });
    }

    // ---- temporal ----------------------------------------------------------

    @Test @DisplayName("d_date")
    void dDate() {
        roundTrip("d_date", "DATE '1967-11-06'", rs -> {
            assertEquals(Date.valueOf("1967-11-06"), rs.getDate("d_date"));
            return null;
        });
    }

    @Test @DisplayName("d_time")
    void dTime() {
        roundTrip("d_time", "TIME '12:34:56'", rs -> {
            assertEquals(Time.valueOf("12:34:56"), rs.getTime("d_time"));
            return null;
        });
    }

    @Test @DisplayName("d_timetz")
    void dTimetz() {
        roundTrip("d_timetz", "TIME WITH TIME ZONE '12:34:56+00'", rs -> {
            assertNotNull(rs.getString("d_timetz"));
            return null;
        });
    }

    @Test @DisplayName("d_ts")
    void dTs() {
        roundTrip("d_ts", "TIMESTAMP '1967-11-06 12:34:56'", rs -> {
            assertEquals(Timestamp.valueOf("1967-11-06 12:34:56"),
                         rs.getTimestamp("d_ts"));
            return null;
        });
    }

    @Test @DisplayName("d_tstz")
    void dTstz() {
        roundTrip("d_tstz", "TIMESTAMPTZ '1967-11-06 12:34:56+00'", rs -> {
            assertNotNull(rs.getTimestamp("d_tstz"));
            return null;
        });
    }

    @Test @DisplayName("d_intv_ym")
    void dIntvYm() {
        roundTrip("d_intv_ym", "INTERVAL '2 years 3 months'", rs -> {
            PGInterval iv = (PGInterval) rs.getObject("d_intv_ym");
            assertEquals(2, iv.getYears());
            assertEquals(3, iv.getMonths());
            return null;
        });
    }

    @Test @DisplayName("d_intv_ds")
    void dIntvDs() {
        roundTrip("d_intv_ds", "INTERVAL '1 day 2:03:04'", rs -> {
            PGInterval iv = (PGInterval) rs.getObject("d_intv_ds");
            assertEquals(1, iv.getDays());
            assertEquals(2, iv.getHours());
            return null;
        });
    }

    // ---- misc --------------------------------------------------------------

    @Test @DisplayName("b_bool")
    void bBool() {
        roundTrip("b_bool", "TRUE", rs -> {
            assertTrue(rs.getBoolean("b_bool"));
            return null;
        });
    }

    @Test @DisplayName("b_bytea")
    void bBytea() {
        roundTrip("b_bytea", "'\\x6a6b6c'::bytea", rs -> {
            assertArrayEquals(new byte[]{0x6a, 0x6b, 0x6c}, rs.getBytes("b_bytea"));
            return null;
        });
    }

    @Test @DisplayName("m_money")
    void mMoney() {
        roundTrip("m_money", "1234.56::money", rs -> {
            assertNotNull(rs.getString("m_money"));
            return null;
        });
    }

    @Test @DisplayName("u_uuid")
    void uUuid() {
        String u = "11111111-2222-3333-4444-555555555555";
        roundTrip("u_uuid", "'" + u + "'::uuid", rs -> {
            assertEquals(UUID.fromString(u), rs.getObject("u_uuid", UUID.class));
            return null;
        });
    }

    // ---- network -----------------------------------------------------------

    @Test @DisplayName("net_inet")
    void netInet() {
        roundTrip("net_inet", "'192.168.0.1'::inet", rs -> {
            assertEquals("192.168.0.1", rs.getString("net_inet"));
            return null;
        });
    }

    @Test @DisplayName("net_cidr")
    void netCidr() {
        roundTrip("net_cidr", "'192.168.0.0/24'::cidr", rs -> {
            assertEquals("192.168.0.0/24", rs.getString("net_cidr"));
            return null;
        });
    }

    @Test @DisplayName("net_mac")
    void netMac() {
        roundTrip("net_mac", "'08:00:2b:01:02:03'::macaddr", rs -> {
            assertEquals("08:00:2b:01:02:03", rs.getString("net_mac"));
            return null;
        });
    }

    @Test @DisplayName("net_mac8")
    void netMac8() {
        roundTrip("net_mac8", "'08:00:2b:01:02:03:04:05'::macaddr8", rs -> {
            assertEquals("08:00:2b:01:02:03:04:05", rs.getString("net_mac8"));
            return null;
        });
    }

    // ---- bits --------------------------------------------------------------

    @Test @DisplayName("bits_fixed")
    void bitsFixed() {
        roundTrip("bits_fixed", "B'10101010'", rs -> {
            assertEquals("10101010", rs.getString("bits_fixed"));
            return null;
        });
    }

    @Test @DisplayName("bits_varying")
    void bitsVarying() {
        roundTrip("bits_varying", "B'1011'", rs -> {
            assertEquals("1011", rs.getString("bits_varying"));
            return null;
        });
    }

    // ---- ranges ------------------------------------------------------------

    @Test @DisplayName("range_int")
    void rangeInt() {
        roundTrip("range_int", "'[1,10)'::int4range", rs -> {
            assertEquals("[1,10)", rs.getString("range_int"));
            return null;
        });
    }

    @Test @DisplayName("range_num")
    void rangeNum() {
        roundTrip("range_num", "'[1.5,9.5)'::numrange", rs -> {
            assertTrue(rs.getString("range_num").startsWith("["));
            return null;
        });
    }

    @Test @DisplayName("range_ts")
    void rangeTs() {
        roundTrip("range_ts",
            "'[1967-11-06, 1970-01-01)'::tsrange", rs -> {
            assertTrue(rs.getString("range_ts").contains("1967-11-06"));
            return null;
        });
    }

    @Test @DisplayName("multirange_int")
    void multirangeInt() {
        roundTrip("multirange_int",
            "'{[1,5), [10,15)}'::int4multirange", rs -> {
            String v = rs.getString("multirange_int");
            assertTrue(v.contains("[1,5)") && v.contains("[10,15)"));
            return null;
        });
    }

}
