package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.DbFixture;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGobject;

import static org.junit.jupiter.api.Assertions.assertTrue;

/** int4range, numrange, tsrange, int4multirange columns. */
@DisplayName("scalar_zoo — write (ranges)")
class ScalarZooRangeWriteTest {

    private static DbFixture.Binder pgObject(String type, String value) {
        return (ps, i) -> {
            PGobject o = new PGobject();
            o.setType(type);
            o.setValue(value);
            ps.setObject(i, o);
        };
    }

    @Test @DisplayName("range_int via PGobject('int4range')")
    void rangeInt() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "range_int", pgObject("int4range", "[1,10)"));
            assertTrue(DbFixture.readScalar(c, "range_int",
                rs -> rs.getString("range_int")).contains("1"));
        });
    }

    @Test @DisplayName("range_num via PGobject('numrange')")
    void rangeNum() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "range_num", pgObject("numrange", "[1.5,9.5)"));
            assertTrue(DbFixture.readScalar(c, "range_num",
                rs -> rs.getString("range_num")).startsWith("["));
        });
    }

    @Test @DisplayName("range_ts via PGobject('tsrange')")
    void rangeTs() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "range_ts",
                pgObject("tsrange", "[1967-11-06, 1970-01-01)"));
            assertTrue(DbFixture.readScalar(c, "range_ts",
                rs -> rs.getString("range_ts")).contains("1967-11-06"));
        });
    }

    @Test @DisplayName("multirange_int via PGobject('int4multirange')")
    void multirangeInt() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "multirange_int",
                pgObject("int4multirange", "{[1,5),[10,15)}"));
            assertTrue(DbFixture.readScalar(c, "multirange_int",
                rs -> rs.getString("multirange_int")).contains("[1,5)"));
        });
    }
}
