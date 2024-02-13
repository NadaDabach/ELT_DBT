{%- set source_model = ["stg_store_and_fwd"] -%}
{%- set src_pk = "STORAGE_TRIP_PK" -%}
{%- set src_fk = ["STORAGE_PK", "TAXI_TRIPS_PK"] -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}