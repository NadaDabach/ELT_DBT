select RATE_PK,RATE_TYPE,total_taxi
from {{source('marts_source','sat_business_rate')}}