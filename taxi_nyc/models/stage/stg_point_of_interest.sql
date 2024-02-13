{%- set yaml_metadata -%}
source_model: 'raw_point_of_interest'
derived_columns:
    PI_KEY: PLACEID
    PI_GEOMETRY: THE_GEOM_POI
    RECORD_SOURCE: '!TAXI_NYC_POINT_OF_INTEREST'
    LOAD_DATE: DATEADD(MINUTE, 60, LOAD_DATE)
    EFFECTIVE_FROM : LOAD_DATE
hashed_columns:
    PI_PK: PLACEID
    ZONES_PK: OBJECTID
    POI_ZONES_PK:
        - PLACEID
        - OBJECTID
    PI_HASHDIFF:
        is_hashdiff: true
        columns:
          - PLACEID
          - SEGMENTID
          - COMPLEXID
          - SAFTYPE
          - SOS
          - FACI_DOM
          - BIN
          - BOROUGH
          - CREATED
          - MODIFIED
          - FACILITY_T
          - SOURCE
          - B7SC
          - PRI_ADD
          - NAME
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