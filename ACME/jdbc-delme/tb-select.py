# https://stackoverflow.com/questions/55376100/create-a-jtds-connection-string-in-python
import sys
import jaydebeapi


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

        MSSQL_DRIVER = "net.sourceforge.jtds.jdbc.Driver"
        # busche-sql.BUSCHE-CNC.com (10.1.2.74)
        host = 'plt6tb'
        port = '1433'
        user = 'sa'
        password = 'sps12345'
        db_url = f"jdbc:jtds:sqlserver://{host}:{port}/sps;"
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

        # Establish connection.
        # connection = jaydebeapi.connect(driver_name, connection_url, connection_properties, jar_path)
        cursor = connection.cursor()

        # Execute test query.
        cursor.execute("select top 10 * from jobs")
        # cursor.execute("select 1 as test_connection")
        res = cursor.fetchall()
        if res:
            print(str(res))  # Should print [(1,)]
        connection.close()

    except Exception as err:
        print(str(err))


if __name__ == "__main__":
    sys.exit(main())