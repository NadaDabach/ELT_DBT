select ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as id,
        ratecodeid,
        rate_type,
        current_date() as load_date
from  {{ source('taxi_nyc_data', 'taxi_trips') }} AS trips join {{ source('taxi_nyc_data', 'rate') }} as rate
on trips.ratecodeid = rate.rate_id