package ie.rolfe.dbhell.postgres.write;

import ie.rolfe.dbhell.postgres.testkit.BindProbe;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.io.ByteArrayInputStream;

import static org.junit.jupiter.api.Assertions.assertArrayEquals;

/** bytea — JDBC binary bindings. */
@DisplayName("bytea — JDBC bindings")
class BByteaBindingTest {

    private static final String DDL = "bytea";
    private static final byte[] EXPECT = {0x6a, 0x6b, 0x6c};

    @Test @DisplayName("setBytes")
    void setBytes() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setBytes(i, EXPECT),
            rs -> rs.getBytes(BindProbe.COLUMN),
            (e, a) -> assertArrayEquals(EXPECT, a), null);
    }

    @Test @DisplayName("setBinaryStream")
    void setBinaryStream() {
        BindProbe.bindAndCheck(DDL,
            (ps, i) -> ps.setBinaryStream(i, new ByteArrayInputStream(EXPECT), EXPECT.length),
            rs -> rs.getBytes(BindProbe.COLUMN),
            (e, a) -> assertArrayEquals(EXPECT, a), null);
    }

    @Test @DisplayName("setObject(byte[])")
    void setObjectBytes() {
        BindProbe.bindAndCheck(DDL, (ps, i) -> ps.setObject(i, EXPECT),
            rs -> rs.getBytes(BindProbe.COLUMN),
            (e, a) -> assertArrayEquals(EXPECT, a), null);
    }
}
