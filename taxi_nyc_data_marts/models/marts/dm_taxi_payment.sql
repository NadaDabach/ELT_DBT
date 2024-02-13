select l.TAXI_TRIPS_PK, s.PAYMENT_TYPE
from {{source('marts_source','link_business_payment_taxi_trips')}} as l join {{source('marts_source','sat_business_payment')}} as s
on l.PAYMENT_PK = s.PAYMENT_PK