# https://stackoverflow.com/questions/72128006/connect-to-mssql-using-python-jaydebeapi-from-inside-a-docker-image
# https://github.com/baztian/jaydebeapi
# https://kontext.tech/article/386/connect-to-sql-server-via-jaydebeapi-in-python
# ENV LD_LIBRARY_PATH="/usr/lib/jvm/java-1.8-openjdk/jre/lib/amd64/server"
# import pandas as pd
import jaydebeapi
import argparse
import json
from datetime import datetime
import os


# def read_data():
#     MSSQL_DRIVER = "net.sourceforge.jtds.jdbc.Driver"
#     host = 'server_name'
#     port = '1433'
#     user = 'user'
#     password = 'password'
#     db_url = f"jdbc:jtds:sqlserver://{host}:{port};"
#     connection_properties = {
#     "user": user,
#     "password": password
#     }
#     jar_path = './jtds-1.3.1.jar'
#     connection = jaydebeapi.connect(MSSQL_DRIVER, db_url, connection_properties, jar_path)
#     query = 'SELECT TOP 10 * FROM table_name;'
#     data = pd.read_sql_query(query,connection)
#     print(data)
#     connection.close()

def read_data():
  try:
    MSSQL_DRIVER = "net.sourceforge.jtds.jdbc.Driver"
    # busche-sql.BUSCHE-CNC.com (10.1.2.74)
    host = 'busche-sql'
    port = '1433'
    database = 'cribmaster'
    user = 'sa'
    password = 'buschecnc1'
    db_url = f"jdbc:jtds:sqlserver://{host}:{port}/{database};"
    connection_properties = {
    "user": user,
    "password": password
    }
    # remember classpath needs to be set in crontab
    # 
    # Get environment variables
    classpath = '/usr/lib/jvm/ext'
    jar_path = classpath + '/jtds-1.3.1.jar'
    # jar_path = './jtds-1.3.1.jar'
    # jar_path = '/home/brent/src/linux-utils/jdbc/jtds-1.3.1.jar'

    connection = jaydebeapi.connect(MSSQL_DRIVER, db_url, connection_properties, jar_path)
    cursor = connection.cursor()
    cursor.execute("select 1 as test_connection")
    res = cursor.fetchall()
    if res:
        print(str(res))  # Should print [(1,)]

    # Execute test query.
    # cursor.execute("select top 10 * from plx_Detailed_Production_History")

    # query = 'SELECT TOP 10 * FROM table_name;'
    # data = pd.read_sql_query(query,connection)
    # print(data)
    connection.close()
  except Exception as err:
      print(str(err))


if __name__ == "__main__":
    read_data()