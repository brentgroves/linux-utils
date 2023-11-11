package mobex.jdbc;  
// https://razorsql.com/articles/ms_sql_server_jdbc_connect.html
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
// import mypack.JdbcToolBossConnection;

public class JdbcMain {
 
  public static void main(String[] args) {

      Connection conn = null;
      // https://stackoverflow.com/questions/26269193/how-to-call-a-method-function-from-another-class
      // B b; // A reference to B
      // b = new B(); // Creating object of class B
      // b.doSomething();  // Calling a method contained in class B from class A
      // JdbcToolBoss tb;
      // tb = new JdbcToolBoss();
      // String[] tb_args = {"aa", "bb"};
      // tb.connect(tb_args);
      // try {
      // System.out.println("name = " + rs.getString("name"));
      System.out.println("Running Cribmaster test");
      JdbcCribmaster cm = new JdbcCribmaster();
      cm.connect();
      // System.out.println("Running Toolboss test");
      // JdbcToolBoss tb = new JdbcToolBoss();
      // tb.connect();
      // System.out.println("Running Jtds test");
      // JdbcJtds jtds = new JdbcJtds();
      // jtds.connect();
      // System.out.println("Running MySqlDW test");
      // JdbcMySqlDW mysql = new JdbcMySqlDW();
      // mysql.connect();
      // System.out.println("Running AzureDW test");
      // JdbcAzureDW azure = new JdbcAzureDW();
      // azure.connect();
      // System.out.println("Running ETL test");
      // JdbcRestrictionsToDW etl = new JdbcRestrictionsToDW();
      // etl.etl();
      // System.out.println("Running AzureDW test");
      // JdbcToolListJtds tl = new JdbcToolListJtds();
      // tl.connect();

      // } catch (SQLException ex) {
      //     ex.printStackTrace();
      // } catch (ClassNotFoundException ex) {
      //   ex.printStackTrace();
      // }
      // finally {
      //     try {
      //         if (conn != null && !conn.isClosed()) {
      //             conn.close();
      //         }
      //     } catch (SQLException ex) {
      //         ex.printStackTrace();
      //     }
      // }
  }
}