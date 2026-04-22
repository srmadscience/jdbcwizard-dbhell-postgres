-- 08_arrays_and_composites.sql: arrays, composites, enums, domains.
-- Oracle source: Sql/oraclearrays*.sql (VARRAY / nested tables) and
-- Sql/dbhell_objectcols.sql (object columns).

SET search_path = dbhell, public;

-- Enum (closest parser analogue to a constrained Oracle varchar2 check).
CREATE TYPE traffic_light AS ENUM ('red', 'amber', 'green');

-- Composite (Oracle OBJECT equivalent).
CREATE TYPE address_t AS (
    street   text,
    city     text,
    postcode text,
    country  char(2)
);

-- Nested composite (composite-of-composite).
CREATE TYPE contact_t AS (
    name     text,
    email    text,
    home     address_t,
    work     address_t
);

-- Range over a custom domain (CREATE TYPE ... AS RANGE).
CREATE DOMAIN positive_int AS integer CHECK (VALUE > 0);
CREATE TYPE positive_int_range AS RANGE (SUBTYPE = positive_int);

-- Array columns of scalars, composites, and domains.
CREATE TABLE array_example (
    id         bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tags       text[],
    matrix     integer[][],
    addresses  address_t[],
    lights     traffic_light[],
    rng        positive_int_range
);

INSERT INTO array_example (tags, matrix, addresses, lights, rng) VALUES
    ('{a,b,c}', '{{1,2,3},{4,5,6}}',
     ARRAY[ROW('Main',     'Dublin', 'D01', 'IE')::address_t,
           ROW('Elm',      'Cork',   'T12', 'IE')::address_t],
     ARRAY['red','green']::traffic_light[],
     '[1, 10]'::positive_int_range);

-- Exploded / unnested views for code generators.
CREATE VIEW array_example_tags AS
SELECT id, unnest(tags) AS tag FROM array_example;

-- Row-of-row insert via ROW() constructor (Oracle OBJECT constructor analogue).
CREATE TABLE contact_book (
    id       bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    contact  contact_t
);
INSERT INTO contact_book (contact) VALUES
    (ROW('Alice', 'a@example.com',
         ROW('Home Rd', 'Dublin', 'D02', 'IE')::address_t,
         ROW('Work Rd', 'Dublin', 'D03', 'IE')::address_t)::contact_t);

-- Bounded varchar domain: closer to Oracle SUBTYPE ... NOT NULL RANGE.
CREATE DOMAIN iso2_country AS char(2) NOT NULL CHECK (VALUE ~ '^[A-Z]{2}$');
CREATE TABLE country_codes (
    code  iso2_country PRIMARY KEY,
    name  text NOT NULL
);
INSERT INTO country_codes VALUES ('IE', 'Ireland'), ('US', 'United States');
