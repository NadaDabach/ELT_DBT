with t1 as (
    select STORAGE_PK, count(*) as total_taxi
    from {{ ref('link_s_and_f_taxi_trips') }}
    group by STORAGE_PK
)
select t1.STORAGE_PK, s.hashdiff, s.TRIP_RECORD_DESCRIPTION, t1.total_taxi, s.effective_from, s.load_date, s.record_source
from t1 join {{ ref('sat_store_and_fwd') }} as s on t1.STORAGE_PK = s.STORAGE_PK