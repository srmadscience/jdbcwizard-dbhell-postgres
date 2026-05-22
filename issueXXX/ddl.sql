-- Minimal DDL for the BigDecimal -> double precision reproducer.
-- Run against whichever database PG_URL points at (CrateDB or Postgres).

DROP TABLE IF EXISTS bigdecimal_repro;
CREATE TABLE bigdecimal_repro (
    id        int,
    the_value double precision
);
