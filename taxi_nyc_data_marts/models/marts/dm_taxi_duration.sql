select TAXI_TRIPS_PK, lpeppickupdatetime, lpepdropoffdatetime, tripduration_hours, tripduration_minutes, TRIPDISTANCE, TIPAMOUNT
from {{ source('marts_source', 'sat_business_taxi_trips') }}