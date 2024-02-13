with t1 as (
    select VENDOR_PK, count(*) as total_taxi
    from {{ ref('link_vendor_taxi_trips') }}
    group by VENDOR_PK
)
select t1.VENDOR_PK, s.hashdiff, s.VENDOR_DESCRIPTION, t1.total_taxi, s.effective_from, s.load_date, s.record_source
from t1 join {{ ref('sat_vendor') }} as s on t1.VENDOR_PK = s.VENDOR_PK