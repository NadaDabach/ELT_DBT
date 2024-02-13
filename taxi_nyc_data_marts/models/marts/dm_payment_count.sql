select PAYMENT_TYPE,total_taxi
from {{source('marts_source','sat_business_payment')}}