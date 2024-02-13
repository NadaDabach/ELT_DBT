select zones_pk, the_geom, num_points, xmax,xmin,ymax,ymin, wkt, wkb, geojson, zone
from {{ source('marts_source','sat_business_taxi_zones') }}