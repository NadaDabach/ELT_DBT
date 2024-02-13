with t1 as (
    select PAYMENT_PK, count(*) as total_taxi
    from {{ ref('link_payment_taxi_trips') }}
    group by PAYMENT_PK
)
select t1.PAYMENT_PK, s.hashdiff, s.PAYMENT_TYPE, t1.total_taxi, s.effective_from, s.load_date, s.record_source
from t1 join {{ ref('sat_payment') }} as s on t1.PAYMENT_PK = s.PAYMENT_PK