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

  username = 'sa' 
  password = 'buschecnc1' 
  conn = pyodbc.connect('DSN=cm2;UID='+username+';PWD='+ password + ';DATABASE=cribmaster')

  cursor = conn.cursor()

  #Sample select query
  query ='''insert into plx_Detailed_Production_History (pcn)
  values (2)'''
  # cursor.execute(query) 

  im ='''insert into plx_Detailed_Production_History (pcn,production_no)
  values (?,?)'''

  ins ='''insert into plx_Detailed_Production_History (pcn,production_no,part_no,part_key,record_date)
  values (?,?,?,?,?)'''

  print(ins)
  cursor.fast_executemany = True

  cursor.executemany(ins,rec)
  cursor.commit()
  cursor.close()

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