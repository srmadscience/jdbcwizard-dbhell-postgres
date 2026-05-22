# CrateDB BigDecimal → `double precision` reproducer

Self-contained Maven project. Reproduces two distinct defects observed when
`PreparedStatement.setBigDecimal` is bound to a `double precision` column on
CrateDB **6.2.4** via the PostgreSQL JDBC driver **42.7.4**.

The two failure modes:

| # | Input shape | Observed CrateDB behaviour |
|---|---|---|
| 1 | Positive-scale BigDecimal, e.g. `190_487_833_519 × 10⁻³²` (≈ `1.9 × 10⁻²¹`) | Insert is rejected with `Character array is missing "e" notation exponential mark.` The pgjdbc driver sends the value as plain decimal text; the CrateDB protocol parser refuses any numeric literal that is not in scientific notation. |
| 2 | Negative-scale BigDecimal, e.g. `2_051_888 × 10³⁶` (= `2.051888 × 10⁴²`) | Insert succeeds; row is stored as `2_051_888.0`. The unscaled mantissa is preserved but the exponent is silently dropped — **no error reported**. |

Neither defect occurs on PostgreSQL 18.3 — both targeted tests pass against
CrateDB 6.2.4 and fail against Postgres. That inversion is intentional:
the tests are tripwires. When CrateDB fixes the wire-format parser, the
targeted tests will start failing on CrateDB too, signalling that this
repro is no longer needed.

Full discussion of the original 1 000-input scan that surfaced this, and
the failure-mode counts, lives in [`../CRATEDB_MATRIX.md`](../CRATEDB_MATRIX.md)
("Randomised BigDecimal round-trip scans" section).

## Layout

```
issueXXX/
├── README.md                                  (this file)
├── pom.xml                                    (JDK 21 + JUnit 5.11.3 + pgjdbc 42.7.4)
├── ddl.sql                                    (the single DROP/CREATE used by the tests)
└── src/test/java/cratedb/
    └── CrateDbBigDecimalDoubleReproTest.java  (3 tests; @BeforeAll/@AfterAll manage the table)
```

The Java test class creates and drops `bigdecimal_repro` itself — `ddl.sql`
is supplied separately so a non-Java reader can paste the DDL into a CrateDB
session directly.

## Running

```sh
cd issueXXX

# Against the affected CrateDB:
PG_URL='jdbc:postgresql://<host>:5432/crate?stringtype=unspecified' \
  PG_USER=crate PG_PASSWORD='' \
  mvn test
```

Expected on CrateDB 6.2.4:

| Test | Result |
|---|---|
| `positiveScaleRejected` | **pass** — insert rejected with the "missing `e` notation" error |
| `negativeScaleSilentlyTruncated` | **pass** — `2.051888E42` round-trips as `2051888.0` |
| `randomThousand` | **fail** — roughly 469 rejected + 493 silently mismatched out of 1000 |

For comparison, against PostgreSQL 18 the two targeted tests **fail** (Postgres
doesn't exhibit either bug) and `randomThousand` passes. That is the inverse of
CrateDB and confirms the failures are CrateDB-specific.

## Environment variables

| Var | Default |
|---|---|
| `PG_URL` | `jdbc:postgresql://localhost:5432/crate?stringtype=unspecified` |
| `PG_USER` | `crate` |
| `PG_PASSWORD` | empty |

Keep `stringtype=unspecified` in the URL — without it some of the inputs are
also affected by the unrelated `setString` numeric-binding behaviour and the
results become harder to interpret.

## Versions confirmed

- CrateDB 6.2.4
- PostgreSQL JDBC driver 42.7.4
- Java 21
- PostgreSQL 18.3 (control: bugs do not reproduce)

The 1 000-input set is seeded (`0xC0FFEE`) so successive runs are bit-for-bit
identical; this same seed is used by `BigDecimalToDoubleTest#randomThousand`
in the parent project, so the failure counts match what `CRATEDB_MATRIX.md`
records.

## Workarounds (caller side, while CrateDB is unfixed)

- `ps.setObject(i, value, Types.DOUBLE)` or `ps.setDouble(i, value.doubleValue())`
  — does the BigDecimal → double conversion in the client, so CrateDB only
  ever sees the already-collapsed `double`.
- `ps.setString(i, value.toEngineeringString())` together with the
  `stringtype=unspecified` URL parameter — sends the value in scientific
  notation, which the CrateDB parser accepts.
