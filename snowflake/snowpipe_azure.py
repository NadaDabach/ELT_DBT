from snowflake.snowflake_config import execute_query
from config import settings


def create_data_ingestion_pipeline(conn):
    try:
        sql = "CREATE OR REPLACE NOTIFICATION INTEGRATION NYC_TAXI_INTEGRATION " \
              "ENABLED = true " \
              "TYPE = QUEUE " \
              "NOTIFICATION_PROVIDER = AZURE_STORAGE_QUEUE " \
              "AZURE_STORAGE_QUEUE_PRIMARY_URI = 'https://stviseosnowflakedbt.queue.core.windows.net/queuenyc' " \
              "AZURE_TENANT_ID = 'id' ;"

        execute_query(conn, sql)

        show_integ = "SHOW INTEGRATIONS"
        print(execute_query(conn, show_integ))

        integration_description = "DESC NOTIFICATION INTEGRATION NYC_TAXI_INTEGRATION "
        print(execute_query(conn, integration_description))

    except Exception as e:
        print(e)

    finally:
        conn.close


def create_pipe_stage(conn):
    create_pipe_stage = "CREATE OR REPLACE STAGE TAXI_NYC_STAGE " \
                        "URL = '"

    execute_query(conn, create_pipe_stage)
