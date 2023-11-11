# https://www.sqlshack.com/connect-azure-sql-database-using-python-from-ubuntu/
# https://learn.microsoft.com/en-us/sql/connect/python/python-driver-for-sql-server?view=sql-server-ver16
# https://docs.python-zeep.org/en/master/
# conda install -c anaconda pymssql

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

    ret = 0
    # username = 'sa' 
    # password = 'buschecnc1' 
    # conn = pyodbc.connect('DSN=cm;UID='+username+';PWD='+ password + ';DATABASE=cribmaster')
    # [dw]
    # Driver = ODBC Driver 18 for SQL Server  
    # Server = tcp:mgsqlmi.public.48d444e7f69b.database.windows.net,3342
    # Database = mgdw
    # server = 'mgsqlmi.public.48d444e7f69b.database.windows.net'
    # port='3342'
    # # server = 'mgsqlmi.public.48d444e7f69b.database.windows.net,3342'
    # THIS SECTION WORKS FINE
    # database = 'mgdw'
    # username = 'mgadmin'
    # password = 'WeDontSharePasswords1!'
    # # driver= 'ODBC Driver 17 for SQL Server'
    # # driver= 'ODBC Driver 18 for SQL Server'
    # driver= '{ODBC Driver 18 for SQL Server}'
    # with pyodbc.connect('DSN=dw;UID='+username+';PWD='+ password + ';DATABASE=mgdw') as conn:
    # # with pyodbc.connect('DRIVER='+driver+';SERVER=tcp:'+server+';PORT='+port+';DATABASE='+database+';UID='+username+';PWD='+ password) as conn:
    #     with conn.cursor() as cursor:
    #         cursor.execute("select '1' as one, '2' as two;")
    #         row = cursor.fetchone()
    #         while row:
    #             print (str(row[0]) + " " + str(row[1]))
    #             row = cursor.fetchone()

    # CAN NOT GET THIS TO WORK EXCEPT WITH JDBC TJDS DRIVER
    # server = 'busche-sql'
    # database = 'cribmaster'
    # username = 'sa'
    # password = 'buschecnc1'   
    # # # driver= 'ODBC Driver 17 for SQL Server'
    # # driver= '{ODBC Driver 17 for SQL Server}'

    # with pyodbc.connect('DSN=cm3;UID='+username+';PWD='+ password) as conn:
    # # with pyodbc.connect('DSN=cm4;UID='+username+';PWD='+ password + ';DATABASE=cribmaster') as conn:
    # # with pyodbc.connect('DRIVER='+driver+';SERVER=tcp:'+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password) as conn:
    #     with conn.cursor() as cursor:
    #         cursor.execute("select '1' as one '2' as two;")
    #         row = cursor.fetchone()
    #         while row:
    #             print (str(row[0]) + " " + str(row[1]))
    #             row = cursor.fetchone()

    # CAN NOT GET THIS TO WORK EXCEPT WITH JDBC TJDS DRIVER
    # server = 'busche-sql'
    database = 'sps'
    username = 'sa'
    password = 'sps12345'   
    # # driver= 'ODBC Driver 17 for SQL Server'
    # driver= '{ODBC Driver 17 for SQL Server}'

    with pyodbc.connect('DSN=plt6;UID='+username+';PWD='+ password+ ';DATABASE=sps') as conn:
    # with pyodbc.connect('DSN=cm4;UID='+username+';PWD='+ password + ';DATABASE=cribmaster') as conn:
    # with pyodbc.connect('DRIVER='+driver+';SERVER=tcp:'+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password) as conn:
        with conn.cursor() as cursor:
            cursor.execute("select '1' as one '2' as two;")
            res = cursor.fetchall()
            if res:
                print(str(res))  # Should print [(1,)]


            # row = cursor.fetchone()
            # while row:
            #     print (str(row[0]) + " " + str(row[1]))
            #     row = cursor.fetchone()


    # cursor = conn.cursor()
    # cursor.execute("select count(*) cnt from plx_Detailed_Production_History;") 
    # #   cursor.commit()
    # cursor.close()

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