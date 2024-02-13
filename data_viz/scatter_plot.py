import configparser
import os
import matplotlib.pyplot as plt
from snowflake.snowpark.session import Session
from snowflake.snowpark import functions as F
from snowflake.snowpark.types import *
import pandas as pd
from snowflake.snowpark.functions import udf
import datetime as dt
import numpy as np


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

# Create a DataFrame
df = session.sql("SELECT TRIPDISTANCE, tripduration_minutes from dm_taxi_duration LIMIT 10000").collect()

df = pd.DataFrame(df, columns=['TRIPDISTANCE', 'tripduration_minutes'])

# Create a scatter plot
plt.scatter(df['TRIPDISTANCE'], df['tripduration_minutes'])

# Customize the plot
plt.title('Scatter plot')
plt.xlabel('Trip Distance', color='blue')
plt.ylabel('Trip duration', color='blue')

# Add the number of the total taxi on the column
for i, v in enumerate(df['tripduration_minutes']):
    plt.text(df['TRIPDISTANCE'][i], v, str(v), ha='center', va='bottom', fontsize=8)

# Show the plot
plt.show()
plt.savefig('scatter_plot.png')

# Close the Snowflake session
session.close()
