package mobex.jdbc;  
// https://razorsql.com/articles/ms_sql_server_jdbc_connect.html
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JdbcAzureDW {
 
  public void connect() {

      Connection conn = null;

      try {
        // MSSQL_DRIVER = "net.sourceforge.jtds.jdbc.Driver"
        // # busche-sql.BUSCHE-CNC.com (10.1.2.74)
        // host = 'busche-sql'
        // port = '1433'
        // user = 'sa'
        // password = 'buschecnc1'
        // https://stackoverflow.com/questions/32766114/sql-server-jdbc-error-on-java-8-the-driver-could-not-establish-a-secure-connect
        // String dbURL = "jdbc:sqlserver://localhost\\sqlexpress";
        // String user = "sa";
        // String pass = "secret";
          // String dbURL = "jdbc:sqlserver://10.1.2.74:1433;databaseName=cribmaster";
          // jdbc:sqlserver://10.1.2.74:1433;databaseName=cribmaster
          String user = "mgadmin";
          String pass = "WeDontSharePasswords1!";
          System.out.println("Azure DW with Microsoft jdbc driver"); 
          // url=jdbc:sqlserver://$AZ_DATABASE_NAME.database.windows.net:1433;database=demo;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;
          // user=demo@$AZ_DATABASE_NAME
          // password=$AZ_SQL_SERVER_PASSWORD
          // Class dbDriver = Class.forName("net.sourceforge.jtds.jdbc.Driver");
          Class dbDriver = Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
          // url = "jdbc:sqlserver://" +serverName + ":1433;DatabaseName=" + dbName + ";encrypt=true;trustServerCertificate=true;
          // String jdbcURL = "jdbc:sqlserver://mgsqlmi.public.48d444e7f69b.database.windows.net:3342;user=mgadmin@mgsqlmi;password=WeDontSharePasswords1!;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.48d444e7f69b.database.windows.net;loginTimeout=30;";
          String jdbcURL = "jdbc:sqlserver://mgsqlmi.public.48d444e7f69b.database.windows.net:3342;databaseName=mgdw;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.48d444e7f69b.database.windows.net;loginTimeout=30;";
          // String jdbcURL = "jdbc:sqlserver://mgsqlmi.public.48d444e7f69b.database.windows.net:3342;databaseName=mgdw;encrypt=true;trustServerCertificate=true;";
          // String jdbcURL = "jdbc:jtds:sqlserver://10.1.3.80:1433;databaseName=sps;encrypt=true;trustServerCertificate=true;";
          // String jdbcURL = "jdbc:jtds:sqlserver://10.1.2.74:1433;databaseName=cribmaster";
          conn = DriverManager.getConnection(jdbcURL, user, pass);
          // String jdbcURL = "jdbc:sqlserver://192.168.1.172:53000;databaseName=sample;selectMethod=cursor"; 
          // Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
          // DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());          
          Statement statement = conn.createStatement();
          ResultSet rs = statement.executeQuery("SELECT top 5 * from Plex.account_period_balance");
          while(rs.next())
          {
            System.out.println("pcn = " + rs.getInt("pcn"));
            System.out.println("account_no = " + rs.getString("account_no"));
          }
          // conn = DriverManager.getConnection(dbURL, user, pass);
          // if (conn != null) {
          //     DatabaseMetaData dm = (DatabaseMetaData) conn.getMetaData();
          //     System.out.println("Driver name: " + dm.getDriverName());
          //     System.out.println("Driver version: " + dm.getDriverVersion());
          //     System.out.println("Product name: " + dm.getDatabaseProductName());
          //     System.out.println("Product version: " + dm.getDatabaseProductVersion());
          // }

      } catch (SQLException ex) {
          ex.printStackTrace();
      } catch (ClassNotFoundException ex) {
        ex.printStackTrace();
      }
      finally {
          try {
              if (conn != null && !conn.isClosed()) {
                  conn.close();
              }
          } catch (SQLException ex) {
              ex.printStackTrace();
          }
      }
  }
}