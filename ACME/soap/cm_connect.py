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
# https://github.com/mkleehammer/pyodbc/issues/610
# https://stackoverflow.com/questions/57265913/error-tcp-provider-error-code-0x2746-during-the-sql-setup-in-linux-through-te/57453901#57453901
# https://askubuntu.com/questions/1284658/how-to-fix-microsoft-odbc-driver-17-for-sql-server-ssl-provider-ssl-choose-cli/1289910#1289910
# https://forum.qt.io/topic/137595/unable-to-connect-to-mssql-server-from-qt-application-in-ubuntu/5
    username = 'sa' 
    password = 'buschecnc1' 
    # conn = pyodbc.connect('DSN=cm;UID='+username+';PWD='+ password + ';DATABASE=cribmaster;')
    # Driver={ODBC Driver 13 for SQL Server};Server=tcp:mgsqlmi.public.48d444e7f69b.database.windows.net,3342;Uid=mgadmin@mgsqlmi;Pwd={your_password_here};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;
    # conn = pyodbc.connect('DSN=cm;UID='+username+';PWD='+ password + ';DATABASE=cribmaster;encrypt=true;trustServerCertificate=true;')

# https://learn.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server?redirectedfrom=MSDN&view=sql-server-ver16
    # server = 'busche-sql'
    # database = 'cribmaster'
    # username = 'sa'
    # password = 'buschecnc1'   
    # # driver= 'ODBC Driver 17 for SQL Server'
    # driver= '{ODBC Driver 17 for SQL Server}'

    conn = pyodbc.connect("Driver={ODBC Driver 17 for SQL Server};Server=tcp:busche-sql,1433;Uid=sa;Pwd=buschecnc1;Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;")

    # with pyodbc.connect('DRIVER='+driver+';SERVER=tcp:'+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password) as conn:
    #     with conn.cursor() as cursor:
    #         cursor.execute("select top 10 * from dbo.btToolItems")
    #         row = cursor.fetchone()
    #         while row:
    #             print (str(row[0]) + " " + str(row[1]))
    #             row = cursor.fetchone()
    
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