thank you Father for this beautiful day.
go to jdbc-test for an ETL example.
We think the jTDS or microsoft jdbc driver is better to connect to non-Azure SQL servers under Ubuntu. When we use the microsoft ODBC driver for linux a connection is not always possible due to SSL problems.  More information is found at https://www.mehmetcanyegen.com/pyodbc-0x2746-10054-fix-ubuntu-20-04-lts/. Maybe because of this SSL issue Microsoft lists Ubuntu as not supported for there ODBC driver.
From java/tutorial/mssql/ we can connect to the Tool Boss using both the jTDS and microsoft jdbc drivers.:
javac -d . JdbcToolBossConnection.java  
java -cp ./mssql-jdbc-11.2.0.jre11.jar:. mypack.JdbcToolBossConnection
java -cp ./jtds-1.3.1.jar:. mypack.JdbcToolBossConnection

Tried to change the openssl configuration file as suggested in the many articles concerning the 0x2746-10054 sql connect error without success.
