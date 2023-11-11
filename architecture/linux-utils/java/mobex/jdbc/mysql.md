https://www.javatpoint.com/package

javac -d . JdbcSQLServerConnection.java  
java -cp . mypack.JdbcSQLServerConnection
https://razorsql.com/articles/ms_sql_server_jdbc_connect.html

export CLASSPATH=/home/brent/src/linux-utils/java/tutorial/mssql/mssql-jdbc-11.2.0.jre11.jar

export CLASSPATH=/home/brent/src/linux-utils/java/tutorial/mssql/jtds-1.3.1.jar

/usr/lib/jvm/ext/*.jar
/home/brent/src/linux-utils/jdbc/jtds-1.3.1.jar

java -cp /home/brent/src/linux-utils/jdbc/jtds-1.3.1.jar:. mypack.JdbcSQLServerConnection


java -cp ./jtds-1.3.1.jar:. mypack.JdbcSQLServerConnection

java -cp ./mssql-jdbc-11.2.0.jre11.jar:. mypack.JdbcSQLServerConnection


javac -d . JdbcToolBossConnection.java  
java -cp ./mssql-jdbc-11.2.0.jre11.jar:. mypack.JdbcToolBossConnection
java -cp ./jtds-1.3.1.jar:. mypack.JdbcSQLServerConnection JdbcSQLServerConnection

https://www.mehmetcanyegen.com/pyodbc-0x2746-10054-fix-ubuntu-20-04-lts/