-- Specify the source table and its columns
WITH source_table AS (
    SELECT
        objectid,
        shape_leng,
        PARSE_JSON(the_geom) AS geom_json,
        shape_area,
        zone,
        locationid,
        borough,
        CURRENT_DATE() AS load_date
    FROM
        {{ source('taxi_nyc_data', 'taxi_zones') }}
)

-- Define the columns and their types in the raw model
SELECT
    objectid,
    shape_leng,
    to_geometry(PARSE_JSON('{
        "type": "MultiPolygon",
        "coordinates": ' || geom_json || '
    }') ) AS the_geom,
    shape_area,
    zone,
    locationid,
    borough,
    load_date
FROM
    source_table
