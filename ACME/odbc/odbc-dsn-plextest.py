import pyodbc 
# https://docs.microsoft.com/en-us/sql/connect/python/pyodbc/step-1-configure-development-environment-for-pyodbc-python-development?view=sql-server-ver15
# docker run -it --name my-manim-container -v "/home/bgroves@BUSCHE-CNC.COM/srcmanim:/manim" manimcommunity/manim /bin/bash
# Some other example server values are
# server = 'localhost\sqlexpress' # for a named instance
# server = 'myserver,port' # to specify an alternate port
# MSSQLTest
username = 'mg.odbcalbion' 
password = 'Mob3xalbion' 
cnxn = pyodbc.connect('DSN=PlexTest;UID='+username+';PWD='+ password)
# cnxn = pyodbc.connect( 
#     driver='{ODBC Driver 17 for SQL Server}', 
#     server='hostname,1433', 
#     database='db1', 
#     uid='user1', 
#     pwd='<pass>', 
#     encrypt='yes', 
#     trust_server_certificate='no') 

# cnxn = pyodbc.connect( 
#     driver='{ODBC Driver 17 for SQL Server}', 
#     server='hostname,1433', 
#     database='db1', 
#     uid='user1', 
#     pwd='<pass>', 
#     encrypt='yes', 
#     trust_server_certificate='no') 
# server = 'tcp:mgsqlmi.public.48d444e7f69b.database.windows.net,3342' 
# database = 'mgdw' 
# username = 'mgadmin' 
# password = 'WeDontSharePasswords1!' 
#cnxn = pyodbc.connect('DRIVER={ODBC Driver 18 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()
#Sample select query
cursor.execute("select count(*) from accounting_v_account;") 
row = cursor.fetchone() 
while row: 
    print(row[0])
    row = cursor.fetchone()