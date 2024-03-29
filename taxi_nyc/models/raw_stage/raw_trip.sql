select ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as id,
        triptype,
        vendor_type as trip_description,
        current_date() as load_date
from  {{ source('taxi_nyc_data', 'taxi_trips') }} AS trips join {{ source('taxi_nyc_data', 'trip') }} as trip
on trips.triptype = trip.trip_id