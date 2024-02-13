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
df = session.sql("SELECT PAYMENT_TYPE, total_taxi from dm_payment_count").collect()
# List to dataframe
df = pd.DataFrame(df, columns=['PAYMENT_TYPE', 'total_taxi'])
print(df)

# Create a histogram with the description as x axis and total_taxi as y axis
plt.bar(df['PAYMENT_TYPE'], df['total_taxi'])

# Customize the plot
plt.title('NYC Taxi Payment Types')
plt.xlabel('Payment Type', color='blue')
plt.ylabel('Total Taxi', color='blue')

# Add the number of the total taxi on the column
for i, v in enumerate(df['total_taxi']):
    plt.text(i, v, str(v), ha='center', va='bottom', fontsize=8)

# Show the plot
plt.show()

# Close the session
session.close()