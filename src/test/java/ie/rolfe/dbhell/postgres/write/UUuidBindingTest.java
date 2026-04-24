package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;

/** uuid — JDBC bindings. */
@DisplayName("uuid — JDBC bindings")
class UUuidBindingTest {

    private static final String DDL = "uuid";
    private static final UUID EXPECT = UUID.fromString("11111111-2222-3333-4444-555555555555");

    @Test @DisplayName("setObject(UUID)")
    void setObjectUuid() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setObject(i, EXPECT),
            rs -> rs.getObject(BindProbe.COLUMN, UUID.class),
            (e, a) -> assertEquals(EXPECT, a), null);
    }

    @Test @DisplayName("setString")
    void setString() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setString(i, EXPECT.toString()),
            rs -> rs.getObject(BindProbe.COLUMN, UUID.class),
            (e, a) -> assertEquals(EXPECT, a), null);
    }
}
