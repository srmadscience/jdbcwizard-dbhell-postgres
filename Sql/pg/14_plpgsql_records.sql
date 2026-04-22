-- 14_plpgsql_records.sql: RECORD, %ROWTYPE, %TYPE, composite row vars,
-- arrays of rows, exceptions.
-- Oracle source: Sql/recordTest*.sql (especially recordTest2.sql at 2385 lines).

SET search_path = dbhell, public;

CREATE TYPE rec_t AS (
    name        varchar(4000),
    name_char   char(20),
    seqno       numeric,
    seqno_big   numeric(38, 0),
    seqno_float double precision,
    date_generic timestamp,
    a_raw       bytea,
    a_clob      text,
    a_blob      bytea
);

-- Function that consumes and returns the composite; OUT params included.
CREATE FUNCTION rec_passthrough(
        IN  p_in  rec_t,
        OUT p_out rec_t,
        INOUT p_inout rec_t)
    LANGUAGE plpgsql AS
$$
BEGIN
    p_out   := p_in;
    p_inout := ROW(p_inout.name || '!',
                   p_inout.name_char,
                   COALESCE(p_inout.seqno, 0) + 1,
                   p_inout.seqno_big,
                   p_inout.seqno_float,
                   p_inout.date_generic,
                   p_inout.a_raw,
                   p_inout.a_clob,
                   p_inout.a_blob)::rec_t;
END;
$$;

-- %ROWTYPE and %TYPE usage.
CREATE FUNCTION copy_emp(p_src bigint) RETURNS base_emp LANGUAGE plpgsql AS
$$
DECLARE
    r   base_emp%ROWTYPE;
    sal base_emp.salary%TYPE;
BEGIN
    SELECT * INTO r FROM base_emp WHERE id = p_src;
    sal := r.salary;
    r.salary := sal * 1.10;
    RETURN r;
END;
$$;

-- Array of composites.
CREATE FUNCTION top_n_emp(p_n integer) RETURNS base_emp[] LANGUAGE plpgsql AS
$$
DECLARE
    result base_emp[] := ARRAY[]::base_emp[];
    r      base_emp%ROWTYPE;
BEGIN
    FOR r IN SELECT * FROM base_emp ORDER BY salary DESC LIMIT p_n LOOP
        result := array_append(result, r);
    END LOOP;
    RETURN result;
END;
$$;

-- EXCEPTION blocks (Oracle-parallel structure).
CREATE FUNCTION safe_divide(p numeric, q numeric)
    RETURNS numeric LANGUAGE plpgsql AS
$$
BEGIN
    RETURN p / q;
EXCEPTION
    WHEN division_by_zero THEN
        RAISE NOTICE 'divide-by-zero, returning NULL';
        RETURN NULL;
    WHEN OTHERS THEN
        RAISE EXCEPTION 'unexpected % / %', p, q USING ERRCODE = 'P0001';
END;
$$;
