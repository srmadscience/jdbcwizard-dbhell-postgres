-- 25_demo_data.sql: seed rows so downstream code generators have predictable
-- SELECT-able content. Oracle source: Sql/demobld.sql.

SET search_path = dbhell, public;

-- A miniature countries exhibit (Oracle: Sql/countries.sql + iso_countries.sql).
CREATE TABLE country (
    iso2   char(2) PRIMARY KEY,
    iso3   char(3) UNIQUE,
    name   text    NOT NULL,
    region text
);
INSERT INTO country VALUES
    ('IE', 'IRL', 'Ireland',        'Europe'),
    ('GB', 'GBR', 'United Kingdom', 'Europe'),
    ('US', 'USA', 'United States',  'Americas'),
    ('JP', 'JPN', 'Japan',          'Asia');

-- message_table (Oracle: Sql/message_table.sql).
CREATE TABLE message_table (
    seqno        bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    message_text varchar(2000) NOT NULL
);
INSERT INTO message_table (message_text) VALUES
    ('hello'), ('world'), ('pg_dbhell loaded');

-- A demo customer + booking pair mirroring AxisTestSqlFiles/DemoAddCust etc.
CREATE TABLE demo_customer (
    cust_id   bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name      text NOT NULL,
    created   timestamptz NOT NULL DEFAULT current_timestamp
);
CREATE TABLE demo_booking (
    booking_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cust_id    bigint NOT NULL REFERENCES demo_customer (cust_id) ON DELETE CASCADE,
    flight     text NOT NULL,
    seats      integer NOT NULL CHECK (seats > 0)
);

INSERT INTO demo_customer (name) VALUES ('Ada'), ('Boris');
INSERT INTO demo_booking (cust_id, flight, seats) VALUES
    (1, 'EI-101', 2),
    (1, 'EI-202', 1),
    (2, 'EI-101', 3);
