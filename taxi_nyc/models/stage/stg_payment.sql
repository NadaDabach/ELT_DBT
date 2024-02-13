{%- set yaml_metadata -%}
    source_model: 'raw_payment'
derived_columns:
    PAYMENT_KEY: PAYMENT_ID
    RECORD_SOURCE: '!TAXI_NYC_PAYMENT'
    LOAD_DATE: DATEADD(MINUTE,60, LOAD_DATE)
    EFFECTIVE_FROM : LOAD_DATE
hashed_columns:
  PAYMENT_PK: PAYMENT_ID
  TAXI_TRIPS_PK: ID
  PAYMENT_TRIP_PK:
    - PAYMENT_ID
    - ID
  PAYMENT_HASHDIFF:
    is_hashdiff: true
    columns:
      - PAYMENT_ID
      - PAYMENT_TYPE
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