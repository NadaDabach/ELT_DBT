select
PI_PK,
HASHDIFF,
SEGMENTID,
THE_GEOM_POI,
ST_AsText(THE_GEOM_POI) as wkt,
COMPLEXID,
SAFTYPE,
SOS,
FACI_DOM,
BIN,
BOROUGH,
CREATED,
MODIFIED,
FACILITY_T,
SOURCE,
NAME
from {{ ref('sat_point_of_interest')}}