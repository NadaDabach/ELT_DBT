select l.TAXI_TRIPS_PK, s.RATE_TYPE
from {{source('marts_source','link_business_rate_taxi_trips')}} as l join {{source('marts_source','sat_business_rate')}} as s
on l.RATE_PK = s.RATE_PK