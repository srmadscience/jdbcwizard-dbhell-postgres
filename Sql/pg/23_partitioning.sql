-- 23_partitioning.sql: declarative partitioning — RANGE, LIST, HASH,
-- default partitions, sub-partitioning, attach/detach.
-- Oracle source: Sql/bigtables*.sql (Oracle partitioning syntax differs but
-- the intent is the same — exercise every partition flavour).

SET search_path = dbhell, public;

-- RANGE partitioning with a default partition.
CREATE TABLE part_sales (
    id       bigint GENERATED ALWAYS AS IDENTITY,
    sold_at  timestamp NOT NULL,
    amount   numeric(10, 2) NOT NULL,
    PRIMARY KEY (id, sold_at)
) PARTITION BY RANGE (sold_at);

CREATE TABLE part_sales_2024 PARTITION OF part_sales
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
CREATE TABLE part_sales_2025 PARTITION OF part_sales
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
CREATE TABLE part_sales_default PARTITION OF part_sales DEFAULT;

INSERT INTO part_sales (sold_at, amount) VALUES
    ('2024-06-01', 100),
    ('2025-06-01', 200),
    ('2030-01-01', 999);

-- LIST partitioning + sub-partitioning.
CREATE TABLE part_customers (
    id     bigint GENERATED ALWAYS AS IDENTITY,
    region text NOT NULL,
    tier   text NOT NULL,
    PRIMARY KEY (id, region, tier)
) PARTITION BY LIST (region);

CREATE TABLE part_customers_eu PARTITION OF part_customers
    FOR VALUES IN ('EU') PARTITION BY LIST (tier);
CREATE TABLE part_customers_eu_gold    PARTITION OF part_customers_eu FOR VALUES IN ('gold');
CREATE TABLE part_customers_eu_silver  PARTITION OF part_customers_eu FOR VALUES IN ('silver');

CREATE TABLE part_customers_us PARTITION OF part_customers
    FOR VALUES IN ('US');
CREATE TABLE part_customers_other PARTITION OF part_customers DEFAULT;

-- HASH partitioning.
CREATE TABLE part_events (
    id   bigint GENERATED ALWAYS AS IDENTITY,
    key  text NOT NULL,
    PRIMARY KEY (id, key)
) PARTITION BY HASH (key);

CREATE TABLE part_events_h0 PARTITION OF part_events FOR VALUES WITH (MODULUS 4, REMAINDER 0);
CREATE TABLE part_events_h1 PARTITION OF part_events FOR VALUES WITH (MODULUS 4, REMAINDER 1);
CREATE TABLE part_events_h2 PARTITION OF part_events FOR VALUES WITH (MODULUS 4, REMAINDER 2);
CREATE TABLE part_events_h3 PARTITION OF part_events FOR VALUES WITH (MODULUS 4, REMAINDER 3);

-- Attach / detach. (A partition may not itself carry an identity column, so
-- we copy with LIKE INCLUDING ALL EXCLUDING IDENTITY.)
CREATE TABLE part_sales_2026 (LIKE part_sales INCLUDING ALL EXCLUDING IDENTITY);
ALTER TABLE part_sales_2026
    ADD CONSTRAINT part_sales_2026_range
        CHECK (sold_at >= '2026-01-01' AND sold_at < '2027-01-01');
ALTER TABLE part_sales ATTACH PARTITION part_sales_2026
    FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');
-- Non-concurrent DETACH (CONCURRENTLY is not allowed while a DEFAULT partition
-- exists on the same parent).
ALTER TABLE part_sales DETACH PARTITION part_sales_2026;
