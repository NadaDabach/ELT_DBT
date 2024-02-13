{%- set source_model = "stg_taxi_trips" -%}
{%- set src_pk = "TAXI_TRIPS_PK" -%}
{%- set src_hashdiff = {"source_column" : "TAXI_TRIPS_HASHDIFF", "alias":"HASHDIFF"} -%}
{%- set src_payload = ["LPEPPICKUPDATETIME", "LPEPDROPOFFDATETIME", "PASSENGERCOUNT", "TRIPDISTANCE", "STOREANDFWDFLAG", "FAREAMOUNT", "EXTRA", "MTATAX", "IMPROVEMENTSURCHARGE", "TIPAMOUNT", "TOLLSAMOUNT", "TOTALAMOUNT"] -%}
{%- set src_eff = "EFFECTIVE_FROM" -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff,
                src_payload=src_payload, src_eff=src_eff,
                src_ldts=src_ldts, src_source=src_source,
                source_model=source_model) }}