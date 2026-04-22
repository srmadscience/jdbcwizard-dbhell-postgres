-- 24_generated_columns.sql: stored + PG18 virtual generated columns, plus
-- expression + partial + INCLUDE indexes.
-- Oracle source: no true analogue (Oracle has virtual columns since 11g but
-- the syntax differs).

SET search_path = dbhell, public;

CREATE TABLE gen_example (
    id         bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    price      numeric(10, 2) NOT NULL,
    qty        integer NOT NULL,
    total_s    numeric(12, 2) GENERATED ALWAYS AS (price * qty) STORED,
    total_v    numeric(12, 2) GENERATED ALWAYS AS (price * qty) VIRTUAL,
    upper_name text GENERATED ALWAYS AS (upper(id::text)) VIRTUAL
);

INSERT INTO gen_example (price, qty) VALUES (9.99, 3), (1.50, 100);

-- Expression index.
CREATE INDEX gen_example_total_s_idx ON gen_example (total_s);

-- Partial + INCLUDE index over the stored column.
CREATE INDEX gen_example_big_idx
    ON gen_example (price)
    INCLUDE (qty)
    WHERE total_s > 50;

-- BRIN for an "append-only"-style table.
CREATE TABLE gen_events (
    id        bigint GENERATED ALWAYS AS IDENTITY,
    created   timestamp NOT NULL DEFAULT current_timestamp,
    src       text NOT NULL,
    PRIMARY KEY (id, created)
) PARTITION BY RANGE (created);
CREATE TABLE gen_events_all PARTITION OF gen_events DEFAULT;
CREATE INDEX gen_events_created_brin ON gen_events USING brin (created);
