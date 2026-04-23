package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.DbFixture;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGInterval;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

/** Write tests for the temporal columns of {@code dbhell.scalar_zoo}. */
@DisplayName("scalar_zoo — write (temporal)")
class ScalarZooTemporalWriteTest {

    @Test @DisplayName("d_date via setDate")
    void dDate() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "d_date",
                (ps, i) -> ps.setDate(i, Date.valueOf("1967-11-06")));
            assertEquals(Date.valueOf("1967-11-06"),
                DbFixture.readScalar(c, "d_date", rs -> rs.getDate("d_date")));
        });
    }

    @Test @DisplayName("d_time via setTime")
    void dTime() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "d_time",
                (ps, i) -> ps.setTime(i, Time.valueOf("12:34:56")));
            assertEquals(Time.valueOf("12:34:56"),
                DbFixture.readScalar(c, "d_time", rs -> rs.getTime("d_time")));
        });
    }

    @Test @DisplayName("d_timetz via setString")
    void dTimetz() {
        DbFixture.withRollback(c -> {
            // PG's time-with-tz has no direct JDBC temporal type; setString works.
            DbFixture.insertScalar(c, "d_timetz",
                (ps, i) -> ps.setString(i, "12:34:56+00"));
            assertNotNull(DbFixture.readScalar(c, "d_timetz", rs -> rs.getString("d_timetz")));
        });
    }

    @Test @DisplayName("d_ts via setTimestamp")
    void dTs() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "d_ts",
                (ps, i) -> ps.setTimestamp(i, Timestamp.valueOf("1967-11-06 12:34:56")));
            assertEquals(Timestamp.valueOf("1967-11-06 12:34:56"),
                DbFixture.readScalar(c, "d_ts", rs -> rs.getTimestamp("d_ts")));
        });
    }

    @Test @DisplayName("d_tstz via setTimestamp")
    void dTstz() {
        DbFixture.withRollback(c -> {
            Timestamp ts = Timestamp.valueOf("1967-11-06 12:34:56");
            DbFixture.insertScalar(c, "d_tstz", (ps, i) -> ps.setTimestamp(i, ts));
            assertNotNull(DbFixture.readScalar(c, "d_tstz", rs -> rs.getTimestamp("d_tstz")));
        });
    }

    @Test @DisplayName("d_intv_ym via setObject(PGInterval)")
    void dIntvYm() {
        DbFixture.withRollback(c -> {
            PGInterval in = new PGInterval(2, 3, 0, 0, 0, 0);
            DbFixture.insertScalar(c, "d_intv_ym", (ps, i) -> ps.setObject(i, in));
            PGInterval out = DbFixture.readScalar(c, "d_intv_ym",
                rs -> (PGInterval) rs.getObject("d_intv_ym"));
            assertEquals(2, out.getYears());
            assertEquals(3, out.getMonths());
        });
    }

    @Test @DisplayName("d_intv_ds via setObject(PGInterval)")
    void dIntvDs() {
        DbFixture.withRollback(c -> {
            PGInterval in = new PGInterval(0, 0, 1, 2, 3, 4.0);
            DbFixture.insertScalar(c, "d_intv_ds", (ps, i) -> ps.setObject(i, in));
            PGInterval out = DbFixture.readScalar(c, "d_intv_ds",
                rs -> (PGInterval) rs.getObject("d_intv_ds"));
            assertEquals(1, out.getDays());
            assertEquals(2, out.getHours());
        });
    }
}
