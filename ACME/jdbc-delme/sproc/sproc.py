# https://stackoverflow.com/questions/55376100/create-a-jtds-connection-string-in-python
import jaydebeapi
import os
import sys 
from datetime import datetime

def print_to_stdout(*a):
    # Here a is the array holding the objects
    # passed as the argument of the function
    print(os.path.basename(__file__)+':',*a, file = sys.stdout)


def print_to_stderr(*a):
    # Here a is the array holding the objects
    # passed as the argument of the function
    print(os.path.basename(__file__)+':',*a, file = sys.stderr)



# https://github.com/baztian/jaydebeapi/issues/70

def main():
    try:
        # # jTDS Driver.
        # driver_name = "net.sourceforge.jtds.jdbc.Driver"
        # # jTDS Connection string.
        # connection_url = "jdbc:jtds:sqlserver://<server_hostname>:<port>/<database_name>"

        # # jTDS Connection properties.
        # # Some additional connection properties you may want to use
        # # "domain": "<domain>"
        # # "ssl": "require"
        # # "useNTLMv2": "true"
        # # See the FAQ for details http://jtds.sourceforge.net/faq.html
        # connection_properties = {
        #     "user": "username",
        #     "password": "password",
        # }

        # https://geekflare.com/calculate-time-difference-in-python/
        start_time = datetime.now()
        end_time = datetime.now()

        current_time = start_time.strftime("%H:%M:%S")
        print_to_stdout(f"Current Time: {current_time=}")

        MSSQL_DRIVER = "net.sourceforge.jtds.jdbc.Driver"
        # busche-sql.BUSCHE-CNC.com (10.1.2.74)
        host = 'busche-sql'
        port = '1433'
        user = 'sa'
        password = 'buschecnc1'
        db_url = f"jdbc:jtds:sqlserver://{host}:{port}/cribmaster;"
        # db_url = f"jdbc:jtds:sqlserver://{host}:{port};"
        connection_properties = {
        "user": user,
        "password": password
        }
        jar_path = '/home/brent/src/linux-utils/jdbc/jtds-1.3.1.jar'
        connection = jaydebeapi.connect(MSSQL_DRIVER, db_url, connection_properties, jar_path)
        # query = 'SELECT TOP 10 * FROM table_name;'
        # data = pd.read_sql_query(query,connection)
        # print(data)
        # connection.close()

        # Path to jTDS Jar
        # jar_path = "<path_to>\\jtds-1.3.1.jar"

        # Establish connection.
        # connection = jaydebeapi.connect(driver_name, connection_url, connection_properties, jar_path)
        cursor = connection.cursor()
# https://stackoverflow.com/questions/59942323/how-use-jaydebeapi-call-store-procedure-oracledb-and-pass-4-argument-in-and-out
#    curs = conn.cursor()
#             curs.execute('call  
#             orcl.MYFUNC(TO_DATE(?,?),?,?,?)',arg_in1,'yyyy/mm/dd',arg_in2,arg_out1,arg_out2))
        # Execute test query.
        # cursor.execute("select top 10 * from plx_Detailed_Production_History")
# curs.execute('call orcl.MYFUNC(TO_DATE(?,?),?,?,?)',
#              (arg_in1, 'yyyy/mm/dd', arg_in2, arg_out1, arg_out2)
#             )
        # rowcount=cursor2.execute("{call Plex.account_period_balance_delete_period_range (?)}",pcn).rowcount
# DECLARE @count INT;
# exec [dbo].[mp_output_param_test] 
#     @col1 = 7,
#     @col2 = @count OUTPUT;
# SELECT @count AS 'Number of products found';

        # cursor.execute("exec mp_insert_char_test(?)",('3'))
        test= cursor.execute('mp_insert_int_test ?','5') # works
        # test= cursor.execute('mp_insert_char_test ?','c') # works
        # test= cursor.execute('mp_insert_char_test 3') # works
        # test= cursor.execute('mp_select_test') # works
        # test= cursor.execute('call mp_select_test') # don't work
        # test= cursor.execute("exec mp_select_test") # works
        res = cursor.fetchall()
        if res:
            print(str(res))  # Should print [(1,)]
        connection.close()

        # cursor.execute("{call sp_UpsertTS(?,?,?,?,?,?)}", (item['id'], item['starttime'], item['endtime'], item['userid'], item['pairid'],item['username']))
        # connection.commit()
        # cursor.close()


        # cursor.execute("select 1 as test_connection")
        # res = cursor.fetchall()
        # if res:
        #     print(str(res))  # Should print [(1,)]
        # connection.close()
    except Exception as err:
        print(str(err))

    except BaseException as error:
        ret = 1
        print('An exception occurred: {}'.format(error))

    finally:
        end_time = datetime.now()
        tdelta = end_time - start_time 
        print_to_stdout(f"total time: {tdelta}") 
        if 'connection' in globals():
            connection.close()
        # sys.exit(ret)

if __name__ == "__main__":
    sys.exit(main())

    # https://stackoverflow.com/questions/72069142/how-to-pass-params-in-jaydebeapi-execute
    # https://peps.python.org/pep-0249/#id14