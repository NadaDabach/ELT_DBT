from flask import Flask, render_template, request
import threading
import pandas as pd
import geopandas as gpd
import matplotlib
import matplotlib.pyplot as plt
from snowflake.snowpark.session import Session
from snowflake.snowpark.types import *
import multiprocessing
import plotly.express as px
import seaborn as sns

matplotlib.use("Agg")
app = Flask(__name__)

#  snowflake configs
user = "Nada"
password = "0192837465@Nn"
account = "LIXUWDH-NK70449"
warehouse = "Taxi_NYC_warehouse"
database = "TAXI_NYC_DATA_MARTS"
schema = "TAXI_NYC_DATA_MARTS_SCHEMA"

CONNECTION_PARAMS = {
    'user': user,
    'password': password,
    'account': account,
    'warehouse': warehouse,
    'database': database,
    'schema': schema
}

#  Create a session
session = Session.builder.configs(CONNECTION_PARAMS).create()


def generate_payment_hist():
    try:
        # Create a DataFrame from Snowflake query result
        df = session.sql("SELECT PAYMENT_TYPE, total_taxi from dm_payment_count").collect()
        df = pd.DataFrame(df, columns=['PAYMENT_TYPE', 'total_taxi'])

        # Create an interactive bar chart using Plotly Express
        fig = px.histogram(df, x='PAYMENT_TYPE', y='total_taxi',
                     )

        # Customize the chart appearance
        fig.update_traces(marker_opacity=0.5)  # Change marker opacity
        fig.update_xaxes(showgrid=False)  # Remove x-axis gridlines
        fig.update_yaxes(showgrid=True)  # Add y-axis gridlines
        fig.update_layout(
            bargap=0.1,  # Adjust gap between bars
            barmode='group',  # Group bars together
        )

        # Save the Plotly figure to an HTML file
        fig.write_html('static/payment_hist_plot.html')

    except Exception as e:
        print(f"Error generating payment histogram: {e}")
        return None


def generate_map_taxi_zones():
    try:
        # Create a DataFrame with zone names and geometries
        query = "SELECT zone, wkt FROM dm_num_point_zones"
        result = session.sql(query).collect()
        df = pd.DataFrame(result, columns=['zone', 'wkt'])
        df['wkt'] = gpd.GeoSeries.from_wkt(df['wkt'])
        my_geo_df = gpd.GeoDataFrame(df, geometry='wkt')

        if my_geo_df.empty:
            print("GeoDataFrame is empty.")
            return

        # Create an interactive map using Plotly
        fig = px.choropleth_mapbox(
            my_geo_df,
            geojson=my_geo_df.geometry,
            locations=df.index,  # Use DataFrame index as location identifier
            # title='NYC Taxi Zones',
            hover_name='zone',  # Display zone names on hover
        )

        # Customize the map layout (optional)
        fig.update_layout(
            mapbox_style="carto-positron",
            mapbox_zoom=9,
            mapbox_center={"lat": 40.7, "lon": -73.9},
        )

        # Save the Plotly figure as an HTML file
        fig.write_html('static/taxi_zones_plot.html')

    except Exception as e:
        print(f"Error generating taxi zones map: {e}")


def generate_trip_distance_duration():
    try:
        df = session.sql("SELECT TRIPDISTANCE, tripduration_minutes, TIPAMOUNT from dm_taxi_duration LIMIT 100").collect()

        df = pd.DataFrame(df, columns=['TRIPDISTANCE', 'tripduration_minutes', 'TIPAMOUNT'])

        print(df.head)
        # Create a scatter plot
        fig = px.scatter(df, x='TRIPDISTANCE', y='tripduration_minutes', color="TIPAMOUNT", hover_data=['TIPAMOUNT'])

        # Save the Plotly figure to an HTML file
        fig.write_html('static/trip_distance_duration.html')

    except Exception as e:
        print(f"Error generating scatter plot: {e}")
        return None


@app.route('/')
def index():
    # Create a separate process for generating the map
    map_process = multiprocessing.Process(target=generate_map_taxi_zones)
    map_process.start()

    # Generate the payment histogram in the main thread
    generate_payment_hist()
    generate_trip_distance_duration()

    # Wait for the map process to complete (optional)
    map_process.join()

    # Render the template with the generated plots
    return render_template('plot.html')


if __name__ == '__main__':
    app.run(debug=True)
