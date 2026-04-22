-- 06_xml_and_json.sql: xml and jsonb exercise.
-- Oracle source: Sql/xmltype_test.sql. Postgres has native xml (requires
-- libxml) and jsonb.

SET search_path = dbhell, public;

CREATE TABLE xml_example (
    id      bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    label   text,
    payload xml
);

INSERT INTO xml_example (label, payload) VALUES
    ('empty',    NULL),
    ('doc',      xmlparse(document '<?xml version="1.0"?><root><a>1</a><a>2</a></root>')),
    ('content',  xmlparse(content  '<frag>hello</frag>')),
    ('generated',
        xmlelement(name root,
            xmlelement(name item, xmlattributes('x' AS kind), 'hi'),
            xmlelement(name item, 'there')));

-- xpath + xmltable
CREATE VIEW xml_items AS
SELECT id, (xpath('//a/text()', payload))::text[] AS items
FROM xml_example
WHERE payload IS NOT NULL;

CREATE TABLE jsonb_example (
    id      bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    payload jsonb,
    -- expression index over jsonb path
    CONSTRAINT jsonb_payload_shape CHECK
        (payload IS NULL OR jsonb_typeof(payload) IN ('object','array'))
);
CREATE INDEX jsonb_example_gin ON jsonb_example USING gin (payload jsonb_path_ops);

INSERT INTO jsonb_example (payload) VALUES
    (NULL),
    ('{"a":1,"b":[true,false,null]}'::jsonb),
    ('[{"k":"v"},{"k":"w"}]'::jsonb);

-- Use jsonb_path_query (SQL/JSON path).
CREATE VIEW jsonb_first_k AS
SELECT id, jsonb_path_query_first(payload, '$[*].k') AS first_k
FROM jsonb_example
WHERE jsonb_typeof(payload) = 'array';
