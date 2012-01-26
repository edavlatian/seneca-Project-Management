/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.persistence;

import java.sql.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import seneca.projectManagement.databaseClasses.Accounts;
import seneca.projectManagement.databaseClasses.Comments;
import seneca.projectManagement.databaseClasses.Company;
import seneca.projectManagement.databaseClasses.Milestone;
import seneca.projectManagement.databaseClasses.Projectfile;
import seneca.projectManagement.databaseClasses.Projects;
import seneca.projectManagement.databaseClasses.Teammember;
import seneca.projectManagement.databaseClasses.Teamprojectranking;
import seneca.projectManagement.databaseClasses.Teams;

/**
 *
 * @author matthewschranz
 */
public final class PersistenceController {
  
  private static Connection conn;
  private static Statement stmt;
  private static String query;
  
  public static boolean addAccount (Accounts aUser) throws SQLException {
    
    try {
      Class.forName(DBConnect.getDriver()).newInstance();
      conn = DriverManager.getConnection(DBConnect.getDbUrl(),
              DBConnect.getDbUser(), DBConnect.getDbPass());
      
      stmt = conn.createStatement();
      query = "INSERT INTO accounts (userFName, userLName, userEmail, userIdentifier, userRole, password)" +
              "VALUES ('" + aUser.getUserfname() + "', '" + aUser.getUserlname() + "', '" +
              aUser.getUseremail() + "', '" + aUser.getUseridentifier() + "', '" + aUser.getUserrole() +
              "' , '" + aUser.getPassword() + "')";
      stmt.executeUpdate(query);
      
      return true;
    }
    catch (Exception e){
      e.printStackTrace();
      System.out.println("Caught some Exception");
      return false;
    }
    finally {
      System.out.println("In finally clause");
      if (conn != null)
        conn.close();
    }
  }
  
}
