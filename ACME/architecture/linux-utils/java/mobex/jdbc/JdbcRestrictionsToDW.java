package mobex.jdbc;  
// https://razorsql.com/articles/ms_sql_server_jdbc_connect.html
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JdbcRestrictionsToDW {
 
  public void etl() {

      Connection conn = null;
      Connection conn2 = null;
      Connection conn3 = null;

      try {
          System.out.println("Making connection to the Albion Tool Boss MSSQL server");
          String user = "sa";
          String pass = "sps12345";
          System.out.println("ToolBoss with Microsoft's jdbc driver"); 
          Class dbDriver = Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
          String jdbcURL = "jdbc:sqlserver://10.1.3.80:1433;databaseName=sps;encrypt=true;trustServerCertificate=true;";
          conn = DriverManager.getConnection(jdbcURL, user, pass);
          Statement statement = conn.createStatement();
          ResultSet rs = statement.executeQuery("select r_user,r_job,r_item from restrictions2");
          // ResultSet rs = statement.executeQuery("select top 5 r_user,r_job,r_item from restrictions2");
          // while(rs.next())
          // {
          //   System.out.println("r_user = " + rs.getString("r_user"));
          //   System.out.println("r_item = " + rs.getString("r_job"));
          // }
          System.out.println("Making connection to the Azure data warehouse");
          String user2 = "mgadmin";
          String pass2 = "WeDontSharePasswords1!";
          System.out.println("Azure DW with Microsoft jdbc driver"); 
          Class dbDriver2 = Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
          String jdbcURL2 = "jdbc:sqlserver://mgsqlmi.public.48d444e7f69b.database.windows.net:3342;databaseName=mgdw;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.48d444e7f69b.database.windows.net;loginTimeout=30;";
          conn2 = DriverManager.getConnection(jdbcURL2, user2, pass2);

          Statement statement2 = conn2.createStatement();
          statement2.execute("TRUNCATE table Validation.restrictions2");

          String SQL2 = "insert into Validation.restrictions2 (R_USER,R_JOB,R_ITEM) " +
             "VALUES(?, ?, ?)";
          PreparedStatement pstmt2 = conn2.prepareStatement(SQL2);
          conn2.setAutoCommit(false);

        //   if (conn2 != null) {
        //     DatabaseMetaData dm = (DatabaseMetaData) conn2.getMetaData();
        //     System.out.println("Driver name: " + dm.getDriverName());
        //     System.out.println("Driver version: " + dm.getDriverVersion());
        //     System.out.println("Product name: " + dm.getDatabaseProductName());
        //     System.out.println("Product version: " + dm.getDatabaseProductVersion());
        //     System.out.println("Batch updates: " + dm.supportsBatchUpdates());
        // }          

          String user3 = "root";
          String pass3 = "password";
          System.out.println("MySql DW with mysql-connector jdbc driver"); 
          Class dbDriver3 = Class.forName("com.mysql.cj.jdbc.Driver");  
          // String jdbcURL3 = "jdbc:mysql://reports03.busche-cnc.com:31008/mysql";  
          String jdbcURL3 = "jdbc:mysql://reports31:30031/mysql";  

          conn3 = DriverManager.getConnection(jdbcURL3, user3, pass3);

          Statement statement3 = conn3.createStatement();
          statement3.execute("TRUNCATE table Validation.restrictions2");

          String SQL3 = "insert into Validation.restrictions2 (R_USER,R_JOB,R_ITEM) " +
            "VALUES(?, ?, ?)";
          PreparedStatement pstmt3 = conn3.prepareStatement(SQL3);
          conn3.setAutoCommit(false);

        //   if (conn3 != null) {
        //     DatabaseMetaData dm = (DatabaseMetaData) conn3.getMetaData();
        //     System.out.println("Driver name: " + dm.getDriverName());
        //     System.out.println("Driver version: " + dm.getDriverVersion());
        //     System.out.println("Product name: " + dm.getDatabaseProductName());
        //     System.out.println("Product version: " + dm.getDatabaseProductVersion());
        //     System.out.println("Batch updates: " + dm.supportsBatchUpdates());
        // }          

          while(rs.next())
          {
            // Get the values from the table1 record
            final String r_user = rs.getString("r_user");
            final String r_job = rs.getString("r_job");
            final String r_item = rs.getString("r_item");

            // Insert a row with these values into table2
            pstmt2.setString(1, r_user);
            pstmt2.setString(2, r_job);
            pstmt2.setString(3, r_item);
            pstmt2.addBatch();

            // Insert a row with these values into table2
            pstmt3.setString(1, r_user);
            pstmt3.setString(2, r_job);
            pstmt3.setString(3, r_item);
            pstmt3.addBatch();

          }
          //Create an int[] to hold returned values
          // int[] count = pstmt.executeBatch();
          pstmt2.executeBatch();
          //Explicitly commit statements to apply changes
          conn2.commit(); 
          conn2.close();  

          System.out.println("Restrictions2 have been copied to the Azure data warehouse");
       
          //Create an int[] to hold returned values
          // int[] count = pstmt.executeBatch();
          pstmt3.executeBatch();
          //Explicitly commit statements to apply changes
          conn3.commit(); 
          conn3.close();  
          System.out.println("Restrictions2 have been copied to the MySQL data warehouse");


          // final PreparedStatement insertStatement =conn2.prepareStatement("insert into Validation.restrictions2 (R_USER,R_JOB,R_ITEM) values(?,?,?)");
          // while(rs.next())
          // {
          //   // Get the values from the table1 record
          //   final String r_user = rs.getString("r_user");
          //   final String r_job = rs.getString("r_job");
          //   final String r_item = rs.getString("r_item");

          //   // Insert a row with these values into table2
          //   insertStatement.clearParameters();
          //   insertStatement.setString(1, r_user);
          //   insertStatement.setString(2, r_job);
          //   insertStatement.setString(3, r_item);
          //   insertStatement.executeUpdate();

          //   // System.out.println("pcn = " + rs.getInt("pcn"));
          //   // System.out.println("account_no = " + rs.getString("account_no"));
          // }

          // https://stackoverflow.com/questions/22624711/how-to-copy-table-from-one-database-to-another
          // https://www.tutorialspoint.com/jdbc/jdbc-batch-processing.htm
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
            if (conn2 != null && !conn2.isClosed()) {
              conn2.close();
            }
            if (conn3 != null && !conn3.isClosed()) {
              conn3.close();
            }
          } catch (SQLException ex) {
              ex.printStackTrace();
          }
      }
  }
}