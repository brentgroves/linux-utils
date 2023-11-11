package mobex.jdbc;  
// https://razorsql.com/articles/ms_sql_server_jdbc_connect.html
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JdbcMySqlDW {
 
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
          String user = "root";
          String pass = "password";
          System.out.println("MySql DW with mysql-connector jdbc driver"); 
          Class dbDriver = Class.forName("com.mysql.cj.jdbc.Driver");  
          // conn = DriverManager.getConnection("jdbc:mysql://reports03:31008/mysql?" +
          //                             "user=root&password=password");
          // Class.forName("com.mysql.cj.jdbc.Driver").newInstance();
          // Class dbDriver = Class.forName("net.sourceforge.jtds.jdbc.Driver");
          // Class dbDriver = Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
          // url = "jdbc:sqlserver://" +serverName + ":1433;DatabaseName=" + dbName + ";encrypt=true;trustServerCertificate=true;
          // String jdbcURL = "jdbc:sqlserver://10.1.3.80:1433;databaseName=sps;encrypt=true;trustServerCertificate=true;";
          // jdbc:mysql://localhost:3306/mgdw
          String jdbcURL = "jdbc:mysql://reports31:30031/mysql";  
          // String jdbcURL = "jdbc:jtds:sqlserver://busche-sql:1433;databaseName=Busche ToolList;encrypt=true;trustServerCertificate=true;";
          // String jdbcURL = "jdbc:jtds:sqlserver://10.1.2.74:1433;databaseName=cribmaster";
          conn = DriverManager.getConnection(jdbcURL, user, pass);
          // String jdbcURL = "jdbc:sqlserver://192.168.1.172:53000;databaseName=sample;selectMethod=cursor"; 
          // Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
          // DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());          
          Statement statement = conn.createStatement();
          ResultSet rs = statement.executeQuery("select * from Plex.account_period_balance limit 5");
          while(rs.next())
          {
            System.out.println("pcn = " + rs.getInt("pcn"));
            System.out.println("account_no = " + rs.getString("account_no"));
          }
          // if (conn != null) {
          //     DatabaseMetaData dm = (DatabaseMetaData) conn.getMetaData();
          //     System.out.println("Driver name: " + dm.getDriverName());
          //     System.out.println("Driver version: " + dm.getDriverVersion());
          //     System.out.println("Product name: " + dm.getDatabaseProductName());
          //     System.out.println("Product version: " + dm.getDatabaseProductVersion());
          //     System.out.println("Product version: " + dm.supportsBatchUpdates());
          
          // }
          // JDBC drivers are not required to support this feature. You should use the DatabaseMetaData.supportsBatchUpdates() method to determine 
          // if the target database supports batch update processing. The method returns true if your JDBC driver supports this feature.
      } catch (SQLException ex) {
          ex.printStackTrace();
      } catch (ClassNotFoundException ex) {
        ex.printStackTrace();
      } catch(Exception e) { 
        System.out.println(e);
      } finally {
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