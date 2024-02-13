select
PI_PK,
HASHDIFF,
SEGMENTID,
THE_GEOM_POI,
wkt,
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
from {{ source('marts_source','sat_business_point_of_interest') }}