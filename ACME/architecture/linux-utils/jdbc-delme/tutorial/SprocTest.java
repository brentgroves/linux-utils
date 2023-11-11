import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;



public class SprocTest {

  private String dbName;
  private Connection con;
  private String dbms;

//   CREATE PROCEDURE Report.trial_balance
// @start_period int,
// @end_period int 
  public void runTrialBalance(Integer start_period_arg, Integer end_period_arg ) throws SQLException {
    CallableStatement cs = null;
    try {
      System.out.println("\nCalling the procedure trial_balance");
      cs = this.con.prepareCall("{call Report.trial_balance(?, ?)}");
      cs.setInt(1,start_period_arg);
      cs.setInt(2,end_period_arg);
      cs.executeQuery();
      ResultSet rs = cs.executeQuery();
    } catch (SQLException e) {
      System.out.println(e);
      // JDBCTutorialUtilities.printSQLException(e);
    } finally {
      if (cs != null) { cs.close(); }
    }
  }

  public static void main(String[] args) {
    Connection myConnection = null;
    if (args[0] == null) {
      System.err.println("Properties file not specified at command line");
      return;
    }

    try {
      myConnection = myJDBCTutorialUtilities.getConnectionToDatabase();

      StoredProcedureMySQLSample myStoredProcedureSample =
        new StoredProcedureMySQLSample(myConnection,
                                       myJDBCTutorialUtilities.dbName,
                                       myJDBCTutorialUtilities.dbms);

//      JDBCTutorialUtilities.initializeTables(myConnection,
//                                             myJDBCTutorialUtilities.dbName,
//                                             myJDBCTutorialUtilities.dbms);


      System.out.println("\nCreating SHOW_SUPPLIERS stored procedure");
      myStoredProcedureSample.createProcedureShowSuppliers();
      
      System.out.println("\nCreating GET_SUPPLIER_OF_COFFEE stored procedure");
      myStoredProcedureSample.createProcedureGetSupplierOfCoffee();

      System.out.println("\nCreating RAISE_PRICE stored procedure");
      myStoredProcedureSample.createProcedureRaisePrice();
      

      System.out.println("\nCalling all stored procedures:");
      myStoredProcedureSample.runStoredProcedures("Colombian", 0.10f, 19.99f);

    } catch (SQLException e) {
      JDBCTutorialUtilities.printSQLException(e);
    } finally {
      JDBCTutorialUtilities.closeConnection(myConnection);
    }
  }
  
}
