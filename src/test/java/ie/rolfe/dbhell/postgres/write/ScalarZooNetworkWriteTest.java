package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.DbFixture;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.postgresql.util.PGobject;

import static org.junit.jupiter.api.Assertions.assertEquals;

/** Network-type columns: inet, cidr, macaddr, macaddr8. */
@DisplayName("scalar_zoo — write (network)")
class ScalarZooNetworkWriteTest {

    private static DbFixture.Binder pgObject(String type, String value) {
        return (ps, i) -> {
            PGobject o = new PGobject();
            o.setType(type);
            o.setValue(value);
            ps.setObject(i, o);
        };
    }

    @Test @DisplayName("net_inet via PGobject")
    void netInet() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "net_inet", pgObject("inet", "192.168.0.1"));
            assertEquals("192.168.0.1",
                DbFixture.readScalar(c, "net_inet", rs -> rs.getString("net_inet")));
        });
    }

    @Test @DisplayName("net_cidr via PGobject")
    void netCidr() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "net_cidr", pgObject("cidr", "192.168.0.0/24"));
            assertEquals("192.168.0.0/24",
                DbFixture.readScalar(c, "net_cidr", rs -> rs.getString("net_cidr")));
        });
    }

    @Test @DisplayName("net_mac via PGobject")
    void netMac() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "net_mac", pgObject("macaddr", "08:00:2b:01:02:03"));
            assertEquals("08:00:2b:01:02:03",
                DbFixture.readScalar(c, "net_mac", rs -> rs.getString("net_mac")));
        });
    }

    @Test @DisplayName("net_mac8 via PGobject")
    void netMac8() {
        DbFixture.withRollback(c -> {
            DbFixture.insertScalar(c, "net_mac8",
                pgObject("macaddr8", "08:00:2b:01:02:03:04:05"));
            assertEquals("08:00:2b:01:02:03:04:05",
                DbFixture.readScalar(c, "net_mac8", rs -> rs.getString("net_mac8")));
        });
    }
}
