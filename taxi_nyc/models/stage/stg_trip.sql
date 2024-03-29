{%- set yaml_metadata -%}
source_model: 'raw_trip'
derived_columns:
  TRIP_KEY: TRIPTYPE
  RECORD_SOURCE: '!TAXI_NYC_TRIP'
  LOAD_DATE: DATEADD(MINUTE, 60, LOAD_DATE)
  EFFECTIVE_FROM : LOAD_DATE
hashed_columns:
  TRIP_PK: TRIPTYPE
  TAXI_TRIPS_PK: ID
  TRIP_TAXI_PK:
    - TRIPTYPE
    - ID
  TRIP_HASHDIFF:
    is_hashdiff: true
    columns:
      - TRIPTYPE
      - TRIP_DESCRIPTION
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