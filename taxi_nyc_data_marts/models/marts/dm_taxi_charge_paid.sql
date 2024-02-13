select TAXI_TRIPS_PK, fareamount, extra, mtatax, improvementsurcharge, tipamount, tollsamount, totalamount
from {{ source('marts_source', 'sat_business_taxi_trips') }}