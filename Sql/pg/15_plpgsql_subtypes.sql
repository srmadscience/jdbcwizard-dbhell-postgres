-- 15_plpgsql_subtypes.sql: PG DOMAINs as the Oracle NATURAL/POSITIVE/SIGNTYPE
-- analogue, plus PLS_INTEGER/BINARY_INTEGER.
-- Oracle source: Sql/plsql_subtypes.sql, Sql/datatypes.sql:33-67.

SET search_path = dbhell, public;

CREATE DOMAIN dom_natural   AS integer CHECK (VALUE >= 0);
CREATE DOMAIN dom_naturaln  AS integer NOT NULL CHECK (VALUE >= 0);
CREATE DOMAIN dom_positive  AS integer CHECK (VALUE > 0);
CREATE DOMAIN dom_positiven AS integer NOT NULL CHECK (VALUE > 0);
CREATE DOMAIN dom_signtype  AS integer CHECK (VALUE IN (-1, 0, 1));
CREATE DOMAIN dom_pls_int   AS integer;
CREATE DOMAIN dom_binary_int AS integer;

CREATE TABLE subtype_example (
    id           bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    c_natural    dom_natural,
    c_naturaln   dom_naturaln DEFAULT 0,
    c_positive   dom_positive,
    c_positiven  dom_positiven DEFAULT 1,
    c_signtype   dom_signtype,
    c_pls_int    dom_pls_int,
    c_binary_int dom_binary_int
);

INSERT INTO subtype_example
    (c_natural, c_positive, c_signtype, c_pls_int, c_binary_int)
VALUES
    (0, 1, -1, 100, 200),
    (5, 7,  0, 101, 201),
    (9, 9,  1, 102, 202);

-- PL/pgSQL uses the domain just like a real type.
CREATE FUNCTION bump_positive(p dom_positive) RETURNS dom_positive
    LANGUAGE plpgsql IMMUTABLE AS
$$ BEGIN RETURN p + 1; END; $$;
