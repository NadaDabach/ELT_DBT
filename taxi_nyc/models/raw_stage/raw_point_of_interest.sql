-- Specify the source table and its columns
WITH source_table AS (
    SELECT
        ST_GeomFromText('POINT(' || CAST(SPLIT_PART(REPLACE(REPLACE(the_geom, '[', ''), ']', ''), ',', 1) AS FLOAT) || ' ' || CAST(SPLIT_PART(REPLACE(REPLACE(the_geom, '[', ''), ']', ''), ',', 2) AS FLOAT) || ')') AS the_geom,
        segmentid,
        complexid,
        saftype,
        sos,
        placeid,
        faci_dom,
        bin,
        borough,
        created,
        modified,
        facility_t,
        source,
        b7sc,
        pri_add,
        name,
        current_date() AS load_date
    FROM
        {{ source('taxi_nyc_data', 'point_of_interest') }}
)

-- Define the columns and their types in the raw model
SELECT
    to_geometry(poi.the_geom) as the_geom_poi,
    segmentid,
    complexid,
    saftype,
    sos,
    placeid,
    faci_dom,
    bin,
    poi.borough,
    created,
    modified,
    facility_t,
    source,
    b7sc,
    pri_add,
    name,
    poi.load_date,
    objectid,
    zones.the_geom
FROM
    source_table as poi left join {{ref('raw_taxi_zones')}} as zones on ST_Contains(zones.the_geom, poi.the_geom)
