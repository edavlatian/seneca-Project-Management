/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import seneca.projectManagement.databaseClasses.Accounts;

/**
 *
 * @author matthewschranz
 */
public final class PersistenceController {
  
  private static Connection conn;
  
  public static boolean addAccount (Accounts aUser) {
    
    try {
      Class.forName(DBConnect.getDriver()).newInstance();
      conn = DriverManager.getConnection(DBConnect.getDbUrl()+DBConnect.getDb(),
              DBConnect.getDbUser(), DBConnect.getDbPass());
      System.out.println("Connected to the database");
      return true;
    }
    catch (Exception e){
      e.printStackTrace();
      return false;
    }
    finally {
      System.out.println("In finally clause");
      //em.close();
    }
  }
  
}
