https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver16#ubuntu18
https://learn.microsoft.com/en-us/sql/connect/python/pymssql/python-sql-driver-pymssql?view=sql-server-ver16
sudo apt-get --assume-yes update  
<!-- FreeTDS is a set of libraries for Unix and Linux that allows your programs to natively talk to Microsoft SQL Server and Sybase databases. -->
sudo apt-get --assume-yes install freetds-dev freetds-bin  
<!-- sudo apt-get --assume-yes install python-dev python-pip   -->
conda install -c conda-forge python-devtools=0.9.0
conda install -c anaconda pip=22.2.2
<!-- > sudo pip install pymssql -->
conda install -c anaconda pymssql=2.2.5 

http://www.pymssql.org/en/stable/freetds.html
connection = pymssql.connect(server='mydbserver:1433', ...)

Testing the connection
If you’re sure that your server is reachable, but pymssql for some reason don’t let you connect, you can check the connection with tsql utility which is part of FreeTDS package:

$ tsql
Usage:  tsql [-S <server> | -H <hostname> -p <port>] -U <username> [-P <password>] [-I <config file>] [-o <options>] [-t delim] [-r delim] [-D database]
(...)
$ tsql -S mydbserver -U user
Note

Use the above form if and only if you specified server alias for mydbserver in freetds.conf. Otherwise use the host/port notation:

$ tsql -H mydbserver -p 1433 -U user
tsql -H busche-sql.busche-cnc.com -p 1433 -U sa

import pymssql  
conn = pymssql.connect(server='yourserver.database.windows.net', user='yourusername@yourserver', password='yourpassword', database='AdventureWorks')  
import pymssql  
conn = pymssql.connect(server='yourserver.database.windows.net', user='yourusername@yourserver', password='yourpassword', database='AdventureWorks')  
cursor = conn.cursor()  
cursor.execute('SELECT c.CustomerID, c.CompanyName,COUNT(soh.SalesOrderID) AS OrderCount FROM SalesLT.Customer AS c LEFT OUTER JOIN SalesLT.SalesOrderHeader AS soh ON c.CustomerID = soh.CustomerID GROUP BY c.CustomerID, c.CompanyName ORDER BY OrderCount DESC;')  
row = cursor.fetchone()  
while row:  
    print(str(row[0]) + " " + str(row[1]) + " " + str(row[2]))     
    row = cursor.fetchone()
Verify mysql31 deployment
Deploy mysql32 and mysql33
then reporting etl deployment
 