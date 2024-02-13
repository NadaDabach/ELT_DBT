with t1 as (
    select TRIP_PK, count(*) as total_taxi
    from {{ ref('link_trip_taxi_trips') }}
    group by TRIP_PK
)
select t1.TRIP_PK, s.hashdiff, s.TRIP_DESCRIPTION, t1.total_taxi, s.effective_from, s.load_date, s.record_source
from t1 join {{ ref('sat_trip') }} as s on t1.TRIP_PK = s.TRIP_PK