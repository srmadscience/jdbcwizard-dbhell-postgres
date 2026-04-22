-- 07_postgis_geometry.sql: PostGIS stand-in for Oracle SDO_GEOMETRY.
-- Oracle source: Sql/sdo_geometry_test.sql.
-- Guarded by \if :{?postgis} in pg_dbhell.sql; only loaded when enabled.

SET search_path = dbhell, public;

CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE geom_example (
    id       bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    label    text,
    g_point     geometry(Point, 4326),
    g_line      geometry(LineString, 4326),
    g_polygon   geometry(Polygon, 4326),
    g_multi     geometry(MultiPolygon, 4326),
    g_collection geometry(GeometryCollection, 4326),
    g_any       geometry
);

CREATE INDEX geom_example_point_gix ON geom_example USING gist (g_point);

INSERT INTO geom_example (label, g_point, g_line, g_polygon) VALUES
    ('dublin',
     ST_SetSRID(ST_MakePoint(-6.2603, 53.3498), 4326),
     ST_SetSRID(ST_MakeLine(ST_MakePoint(-6.26, 53.34), ST_MakePoint(-6.25, 53.35)), 4326),
     ST_SetSRID(ST_GeomFromText('POLYGON((-6.27 53.34,-6.25 53.34,-6.25 53.36,-6.27 53.36,-6.27 53.34))'), 4326));

CREATE VIEW geom_areas AS
SELECT id, label, ST_Area(g_polygon::geography) AS area_m2
FROM geom_example
WHERE g_polygon IS NOT NULL;
