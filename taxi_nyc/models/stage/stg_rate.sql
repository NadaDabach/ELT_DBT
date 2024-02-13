{%- set yaml_metadata -%}
source_model: 'raw_rate'
derived_columns:
  RATE_KEY: RATECODEID
  RECORD_SOURCE: '!TAXI_NYC_RATE'
  LOAD_DATE: DATEADD(MINUTE, 60, LOAD_DATE)
  EFFECTIVE_FROM : LOAD_DATE
hashed_columns:
  RATE_PK: RATECODEID
  TAXI_TRIPS_PK: ID
  RATE_TRIP_PK:
    - RATECODEID
    - ID
  RATE_HASHDIFF:
    is_hashdiff: true
    columns:
      - RATECODEID
      - RATE_TYPE
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