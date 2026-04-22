-- 20_null_and_size.sql: boundaries and NULL edge cases.
-- Oracle sources: Sql/nullandsize.sql, Sql/dollersign.sql.
-- Postgres keeps '' distinct from NULL (unlike Oracle); we exercise both.

SET search_path = dbhell, public;

CREATE TABLE null_vs_empty (
    id      bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tag     text,
    v_text  text,
    v_vch   varchar(10),
    v_char  char(10)
);

INSERT INTO null_vs_empty (tag, v_text, v_vch, v_char) VALUES
    ('all null',   NULL, NULL, NULL),
    ('all empty',  '',   '',   ''),
    ('some null',  NULL, '',   '   '),
    ('some empty', '',   NULL, 'x');

-- Size boundaries: PG varchar(n)/char(n) count characters, not bytes.
CREATE TABLE size_boundaries (
    id          bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    one_byte    varchar(1),
    one_kb      varchar(1024),
    sixty_three char(63),
    -- text is unlimited; exercise a multibyte payload.
    mb_text     text
);

INSERT INTO size_boundaries (one_byte, one_kb, sixty_three, mb_text) VALUES
    ('x',
     repeat('a', 1024),
     rpad('x', 63),
     repeat('✨', 1000));

-- numeric width boundaries.
CREATE TABLE numeric_boundaries (
    n_si    smallint,
    n_i     integer,
    n_bi    bigint,
    n_num   numeric(38, 0),
    n_dec10 numeric(10, 2)
);
INSERT INTO numeric_boundaries VALUES
    (-32768, -2147483648, -9223372036854775808, -99999999999999999999999999999999999999, -99999999.99),
    ( 32767,  2147483647,  9223372036854775807,  99999999999999999999999999999999999999,  99999999.99);
