{%- set yaml_metadata -%}
source_model: 'raw_vendor'
derived_columns:
  VENDOR_KEY: VENDOR_ID
  RECORD_SOURCE: '!TAXI_NYC_VENDOR'
  LOAD_DATE: DATEADD(MINUTE, 60, LOAD_DATE)
  EFFECTIVE_FROM : LOAD_DATE
hashed_columns:
  VENDOR_PK: VENDOR_ID
  TAXI_TRIPS_PK: ID
  VENDOR_TAXI_TRIPS_PK:
    - VENDOR_ID
    - ID
  VENDOR_HASHDIFF:
    is_hashdiff: true
    columns:
      - VENDOR_ID
      - VENDOR_DESCRIPTION
      - EFFECTIVE_FROM
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{% set source_model = metadata_dict['source_model'] %}

{% set derived_columns = metadata_dict['derived_columns'] %}

{% set hashed_columns = metadata_dict['hashed_columns'] %}


{{ automate_dv.stage(include_source_columns=true,
                  source_model=source_model,
                  derived_columns=derived_columns,
                  hashed_columns=hashed_columns,
                  ranked_columns=none) }}