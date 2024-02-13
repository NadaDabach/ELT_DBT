select ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) as id,
        storeandfwdflag as trip_record,
        trip_record_description,
        current_date() as load_date
from  {{ source('taxi_nyc_data', 'taxi_trips') }} AS trips join {{ source('taxi_nyc_data', 'store_and_fwd') }} as sf
on trips.storeandfwdflag = sf.trip_record_id