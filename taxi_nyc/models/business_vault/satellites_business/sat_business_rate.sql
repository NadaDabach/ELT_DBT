with t1 as (
    select RATE_PK, count(*) as total_taxi
    from {{ ref('link_rate_taxi_trips') }}
    group by RATE_PK
)
select t1.RATE_PK, s.hashdiff, s.RATE_TYPE, t1.total_taxi, s.effective_from, s.load_date, s.record_source
from t1 join {{ ref('sat_rate') }} as s on t1.RATE_PK = s.RATE_PK