{%- set source_model = ["stg_vendor"] -%}
{%- set src_pk = "VENDOR_TAXI_TRIPS_PK" -%}
{%- set src_fk = ["VENDOR_PK", "TAXI_TRIPS_PK"] -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                src_source=src_source, source_model=source_model) }}