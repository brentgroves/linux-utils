package mobex.jdbc;  
// https://razorsql.com/articles/ms_sql_server_jdbc_connect.html
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JdbcCribmaster {
 
  public void connect() {
  // public void connect(String[] args) {

      Connection conn = null;

      try {
        // MSSQL_DRIVER = "net.sourceforge.jtds.jdbc.Driver"
        // # busche-sql.BUSCHE-CNC.com (10.1.2.74)
        // host = 'busche-sql'
        // port = '1433'
        // user = 'sa'
        // password = 'buschecnc1'

        // String dbURL = "jdbc:sqlserver://localhost\\sqlexpress";
        // String user = "sa";
        // String pass = "secret";
          // String dbURL = "jdbc:sqlserver://10.1.2.74:1433;databaseName=cribmaster";
          // jdbc:sqlserver://10.1.2.74:1433;databaseName=cribmaster
          String user = "sa";
          String pass = "buschecnc1";
          System.out.println("Welcome to package"); 
          // Class dbDriver = Class.forName("net.sourceforge.jtds.jdbc.Driver");
          Class dbDriver = Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
          String jdbcURL = "jdbc:sqlserver://10.1.2.74:1433;databaseName=cribmaster;encrypt=true;trustServerCertificate=true;";
          // String jdbcURL = "jdbc:sqlserver://10.1.3.80:1433;databaseName=sps;encrypt=true;trustServerCertificate=true;";
          // String jdbcURL = "jdbc:sqlserver://10.1.3.80:1433;databaseName=sps;encrypt=true;trustServerCertificate=true;";

          // String jdbcURL = "jdbc:jtds:sqlserver://10.1.2.74:1433;databaseName=cribmaster";
          conn = DriverManager.getConnection(jdbcURL, user, pass);
          // String jdbcURL = "jdbc:sqlserver://192.168.1.172:53000;databaseName=sample;selectMethod=cursor"; 
          // Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
          // DriverManager.registerDriver(new com.microsoft.sqlserver.jdbc.SQLServerDriver());          
          Statement statement = conn.createStatement();
          ResultSet rs = statement.executeQuery("select * from employee");
          while(rs.next())
          {
            System.out.println("name = " + rs.getString("name"));
            // System.out.println("id = " + rs.getInt("id"));
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