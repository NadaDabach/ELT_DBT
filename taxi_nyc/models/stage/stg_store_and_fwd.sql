{%- set yaml_metadata -%}
source_model: 'raw_store_and_fwd'
derived_columns:
  STORAGE_KEY: TRIP_RECORD
  RECORD_SOURCE: '!TAXI_NYC_STORE_AND_FWD'
  LOAD_DATE: DATEADD(MINUTE, 60, LOAD_DATE)
  EFFECTIVE_FROM : LOAD_DATE
hashed_columns:
  STORAGE_PK: TRIP_RECORD
  TAXI_TRIPS_PK: ID
  STORAGE_TRIP_PK:
    - TRIP_RECORD
    - ID
  STORAGE_HASHDIFF:
    is_hashdiff: true
    columns:
      - TRIP_RECORD
      - TRIP_RECORD_DESCRIPTION
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