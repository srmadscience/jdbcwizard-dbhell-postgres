-- 03_core_datatypes.sql: scalar datatypes.
-- Oracle source: dbhell.sql:75-143, datatypes.sql, datatypes_9i.sql.
-- Covers NUMBER variants, char/varchar, temporal, interval, rowid analogue.

SET search_path = dbhell, public;

-- Oracle all_normal_datatypes — NUMBER(p,s) with negative scale is not
-- supported in PG; use plain numeric there.
CREATE TABLE all_normal_datatypes (
    name          varchar(4000),
    name_char     char(2000),
    seqno         numeric,
    seqno_big     numeric(38, 0),
    seqno_small   numeric,            -- was number(2,-28) in Oracle
    seqno_float   double precision,
    date_generic  date
);

INSERT INTO all_normal_datatypes (name) VALUES ('all null');
INSERT INTO all_normal_datatypes
    (name, name_char, seqno, seqno_big, seqno_small, seqno_float, date_generic)
VALUES
    ('42', '42',
     99999999999999999999999999999999999999,
     99999999999999999999999999999999999999,
     42, 42, current_date);

-- Oracle all_normal_datatypes_9i — timestamp and interval variants.
-- ROWID has no Postgres equivalent; we store the physical "tid" plus a
-- surrogate bigint so downstream code generators still see a PK.
CREATE TABLE all_normal_datatypes_9i (
    id                 bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name               varchar(4000),
    date_generic       date,
    timestamp_generic  timestamp,
    timestamp_tz       timestamp with time zone,
    timestamp_local_tz timestamp with time zone,   -- no true LTZ in PG
    date_year_2_month  interval year to month,
    date_day_2_second  interval day to second(6),
    a_rowid            tid,
    a_u_rowid          text                         -- UROWID has no analogue
);

INSERT INTO all_normal_datatypes_9i (name) VALUES ('all null');
INSERT INTO all_normal_datatypes_9i (name, timestamp_generic)
    VALUES ('all null except timestamp', current_timestamp);
INSERT INTO all_normal_datatypes_9i (name, timestamp_tz)
    VALUES ('all null except timestamp_tz', current_timestamp);
INSERT INTO all_normal_datatypes_9i (name, timestamp_local_tz)
    VALUES ('all null except timestamp_local_tz', current_timestamp);
INSERT INTO all_normal_datatypes_9i (name, date_year_2_month)
    VALUES ('dy2month', INTERVAL '23-2' YEAR TO MONTH);
INSERT INTO all_normal_datatypes_9i (name, date_day_2_second)
    VALUES ('dd2second', INTERVAL '11:12:10.222222' HOUR TO SECOND);

-- Back-fill the tid after insert to mimic "all null except rowid".
INSERT INTO all_normal_datatypes_9i (name, a_rowid)
SELECT 'all null except rowid', ctid
FROM all_normal_datatypes_9i
ORDER BY id
LIMIT 1;

-- Number-format exhibit (dbhell.sql:188-195).
CREATE TABLE numberformat_example (
    name        varchar(256),
    money_value varchar(256),
    numberdata  numeric
);
INSERT INTO numberformat_example VALUES
    (NULL, NULL, NULL),
    ('0', '$0.00', 0),
    ('1', '$1.00', 1),
    ('1,000', '$1,000.00', 1000),
    ('1,000,000', '$1,000,000.00', 1000000),
    ('1,000,000.976', '$1,000,000.98', 1000000.976);

-- Date-format exhibit (dbhell.sql:198-202).
CREATE TABLE dateformat_example (
    name        varchar(256),
    date_value  timestamp,
    date_string varchar(256),
    time_string varchar(256)
);
INSERT INTO dateformat_example VALUES
    (NULL, NULL, NULL, NULL),
    ('midnight', to_timestamp('06-Nov-1967', 'DD-Mon-YYYY'), '1967/11/06', '00:00:00'),
    ('3am',      to_timestamp('06-Nov-1967 03', 'DD-Mon-YYYY HH24'), '1967/11/06', '03:00:00');

-- Number boundaries (dbhell.sql:205-212).
CREATE TABLE number_test (
    name      varchar(256),
    the_value numeric(38, 10)
);
INSERT INTO number_test VALUES
    ('null', NULL),
    ('0', 0),
    ('max_byte', 127),
    ('max_byte+1', 128),
    ('max_short', 65535),
    ('max_short+1', 65536);

-- Boolean exhibit: native bool in Postgres, unlike Oracle's char-coded BOOLEAN.
CREATE TABLE boolean_test (
    name                varchar(256),
    the_character_value varchar(256),
    the_number_value    numeric(38, 10),
    the_native_bool     boolean
);
INSERT INTO boolean_test VALUES
    ('null',   NULL,     NULL,        NULL),
    ('TRUE',  'Y',       1,           true),
    ('TRUE',  'T',       120202020,   true),
    ('TRUE',  'True',    120202020,   true),
    ('TRUE',  'tRue',    0.00000001,  true),
    ('TRUE',  'yes',     1,           true),
    ('FALSE', 'N',       0,           false),
    ('FALSE', 'F',       0,           false),
    ('FALSE', 'false',   0,           false),
    ('FALSE', ' ',       0,           false);

-- Domain-equivalent of Oracle's integer subtypes (NATURAL / POSITIVE / SIGNTYPE)
-- lives in 15_plpgsql_subtypes.sql; this file just covers the built-in scalars.
CREATE TABLE scalar_zoo (
    n_smallint  smallint,
    n_int       integer,
    n_bigint    bigint,
    n_real      real,
    n_double    double precision,
    n_decimal   decimal(20, 6),
    s_text      text,
    s_varchar   varchar(100),
    s_char      char(10),
    s_bpchar    bpchar(5),
    d_date      date,
    d_time      time,
    d_timetz    time with time zone,
    d_ts        timestamp,
    d_tstz      timestamp with time zone,
    d_intv_ym   interval year to month,
    d_intv_ds   interval day to second,
    b_bool      boolean,
    b_bytea     bytea,
    m_money     money,
    u_uuid      uuid,
    net_inet    inet,
    net_cidr    cidr,
    net_mac     macaddr,
    net_mac8    macaddr8,
    bits_fixed  bit(8),
    bits_varying bit varying(64),
    range_int   int4range,
    range_num   numrange,
    range_ts    tsrange,
    multirange_int int4multirange
);
