{%- set source_model = "stg_point_of_interest" -%}
{%- set src_pk = "PI_PK" -%}
{%- set src_hashdiff = {"source_column" : "PI_HASHDIFF", "alias":"HASHDIFF"} -%}
{%- set src_payload = ["SEGMENTID", "THE_GEOM_POI", "COMPLEXID", "SAFTYPE", "SOS", "FACI_DOM", "BIN", "BOROUGH", "CREATED", "MODIFIED", "FACILITY_T", "SOURCE", "B7SC", "PRI_ADD", "NAME"] -%}
{%- set src_eff = "EFFECTIVE_FROM" -%}
{%- set src_ldts = "LOAD_DATE" -%}
{%- set src_source = "RECORD_SOURCE" -%}

{{ automate_dv.sat(src_pk=src_pk, src_hashdiff=src_hashdiff,
                src_payload=src_payload, src_eff=src_eff,
                src_ldts=src_ldts, src_source=src_source,
                source_model=source_model) }}
