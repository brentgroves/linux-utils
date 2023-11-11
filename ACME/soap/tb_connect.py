# https://docs.python-zeep.org/en/master/
#import xmltodict
from zeep import Client
from zeep.transports import Transport

from requests import Session
from requests.auth import HTTPBasicAuth  # or HTTPDigestAuth, or OAuth1, etc.
import pyodbc
import os
import sys 
from datetime import datetime
import mysql.connector
from mysql.connector import Error



def print_to_stdout(*a):
    # Here a is the array holding the objects
    # passed as the argument of the function
    print(os.path.basename(__file__)+':',*a, file = sys.stdout)


def print_to_stderr(*a):
    # Here a is the array holding the objects
    # passed as the argument of the function
    print(os.path.basename(__file__)+':',*a, file = sys.stderr)

try:

    # https://geekflare.com/calculate-time-difference-in-python/
    start_time = datetime.now()
    end_time = datetime.now()

    current_time = start_time.strftime("%H:%M:%S")
    print_to_stdout(f"Current Time: {current_time=}")

    server = '10.1.3.80'
    database = 'sps'
    username = 'sa'
    password = 'sps12345'   
    driver= '{ODBC Driver 18 for SQL Server}'
    # driver= '{ODBC Driver 17 for SQL Server}'
    # tb_connect.py: [08001] [Microsoft][ODBC Driver 18 for SQL Server]SSL Provider: [error:0A000086:SSL routines::certificate verify failed:EE certificate key too weak] (-1) (SQLDriverConnect)
    with pyodbc.connect('DRIVER='+driver+';SERVER=tcp:'+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password) as conn:
        with conn.cursor() as cursor:
            cursor.execute("select top 10 * from dbo.btToolItems")
            row = cursor.fetchone()
            while row:
                print (str(row[0]) + " " + str(row[1]))
                row = cursor.fetchone()

except pyodbc.Error as ex:
    ret = 1
    error_msg = ex.args[1]
    print_to_stderr(error_msg) 

except Error as e:
    ret = 1
    print("Error while connecting to MySQL", e)

except BaseException as error:
    ret = 1
    print('An exception occurred: {}'.format(error))

finally:
    end_time = datetime.now()
    tdelta = end_time - start_time 
    print_to_stdout(f"total time: {tdelta}") 
    if 'conn' in globals():
        conn.close()
    sys.exit(ret)