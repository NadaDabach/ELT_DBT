import pandas as pd
import geopandas as gpd
import matplotlib.pyplot as plt
import configparser
import os
import matplotlib.pyplot as plt
from snowflake.snowpark.session import Session
from snowflake.snowpark.types import *
import pandas as pd

#  snowflake configs
user = "Nada"
password = "0192837465@Nn"
account = "wdjgsnh-js25497"
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

# Create a DataFrame
df = session.sql("SELECT wkt FROM dm_num_point_zones").collect()
# List to dataframe
df = pd.DataFrame(df, columns=['wkt'])
df['wkt']= gpd.GeoSeries.from_wkt(df['wkt'])
print(df)
my_geo_df = gpd.GeoDataFrame(df, geometry='wkt')
# Plot the geometry data
my_geo_df.plot()

# Customize the plot
plt.title('NYC Taxi Zones')
plt.xlabel('Longitude')
plt.ylabel('Latitude')

# Show the plot
plt.show()
# Close the connection
session.close()
