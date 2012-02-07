/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import java.sql.*;
import java.util.ArrayList;
import javax.ejb.LocalBean;
import javax.ejb.Stateful;
import seneca.projectManagement.databaseClasses.Accounts;
import seneca.projectManagement.databaseClasses.Teams;
import seneca.projectManagement.persistence.DBConnect;
import seneca.projectManagement.utils.Matching;

/**
 *
 * @author matthewschranz
 */

/*
 * NOTE:
 * 
 * Add methods as you need them. Insert/Delete/Update/Select whatever
 * the query type is.
 * 
 */
@Stateful
@LocalBean
public class UserSession {

  private Accounts loggedUser;
  private Connection conn;
  private Statement stmt;
  private String query;
  
  // Holds the temporary login user for checking their credentials
  private Accounts tempUser;
  private boolean isLogged;

  public UserSession() {
      tempUser = new Accounts();
      isLogged = false;
  }
  
  public Accounts getLoggedUser() {
    return loggedUser;
  }

  public void setLoggedUser(Accounts loggedUser) {
    this.loggedUser = loggedUser;
  }
  
  public boolean logIn(){
    /*
     * If a row in Accounts is found with a userIdentifier equal to aUsername
     * and the CryptoUtil.encodeBase64(CryptoUtil.digestSHA(aPassphrase)) hashed
     * password is equal then set our account member variable to the pulled down
     * account.
     */
    return checkUser();
  }
  
  public boolean addAccount (Accounts aUser) throws SQLException {
    
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
  
  public boolean removeAccount (int userId) throws SQLException {     
    return false;
  }
  
  public boolean updateAccount (Accounts aAccount) throws SQLException {
    return false;    
  }
  
  // Used by Instructors, Administrators
  public boolean addTeam (Accounts aAccount, Teams aTeam) throws SQLException {
    if (addAccount(aAccount)){
      /*
       * Code to insert team to teams table. Ensure you get the 
       * auto generated account userId first so you can put it in
       * the INSERT INTO TEAMS userId column
       */
      
      return true;
    }
    return false;
  }
  
  public ArrayList<Matching> matchTeamProjects (String semesterIdentifier) throws SQLException {
    /*
     * The expected string format will be like the following:
     * 
     * 122
     * 
     * That would stand for year 2012 Summer Semester.
     * 
     * Then you could do... 
     * SELECT * FROM Teamprojectranking WHERE whenRanked = 'semesterIdentifier'
     * 
     * And convert the ResultSet into Matching Objects (Change the classname if you want)
     * and then stored those in an ArrayList and return it.
     */
    
    return null;
  }
  
  /*********************************************************************************
   * 
   * Kepner's Code
   * 
   *********************************************************************************/
  public void setUsername(String value) {
      tempUser.setUseridentifier(value);
  }
  
  public String getUsername() {
      return tempUser.getUseridentifier();
  }
  
  public String getPassword() {
      return tempUser.getPassword();
  }
  
  public void setPassword(String value) {
      tempUser.setPassword(value);
  }
  
  public boolean getIsLogged() {
      return isLogged;
  }
  
  public String getUserRole() {
      return loggedUser.getUserrole();
  }
  
  private boolean checkUser() {
      boolean value = false;
      try {
        Accounts account = getAccounts(tempUser.getUseridentifier());
        if(account != null) {
            if(tempUser.getPassword().equals(account.getPassword()) == true) {
                loggedUser = account;
                isLogged = true;
                value = true;
            }
        }
        else {
            value = false;
        }
      }
      catch (SQLException e) {
        value = false;
      }
      return value;
  }
  
  private ArrayList<Accounts> getAccounts() throws SQLException {
      try {
      Class.forName(DBConnect.getDriver()).newInstance();
      conn = DriverManager.getConnection(DBConnect.getDbUrl(),
              DBConnect.getDbUser(), DBConnect.getDbPass());
      
      stmt = conn.createStatement();
      query = "select * from accounts";
      ResultSet rs = stmt.executeQuery(query);
      
      ArrayList<Accounts> accounts = new ArrayList<Accounts>();
      Accounts temp;
      while(rs.next()) {
          temp = new Accounts();
          temp.setUserid(rs.getInt("userId"));
          temp.setUseridentifier(rs.getString("userIdentifier"));
          temp.setUserfname(rs.getString("userFName"));
          temp.setUserlname(rs.getString("userLName"));
          temp.setUseremail(rs.getString("userEmail"));
          temp.setUserrole(rs.getString("userRole"));
          temp.setPasswordIsEncrypted(rs.getString("password"));
          temp.setAccountstatus(rs.getInt("accountStatus"));
          accounts.add(temp);
      }
            
      return accounts;
    }
    catch (Exception e){
      e.printStackTrace();
      System.out.println("Caught some Exception");
      return null;
    }
    finally {
      System.out.println("In finally clause");
      if (conn != null)
        conn.close();
    }
  }
  
  private Accounts getAccounts(String userIdentifier) throws SQLException {
      try {
      Class.forName(DBConnect.getDriver()).newInstance();
      conn = DriverManager.getConnection(DBConnect.getDbUrl(),
              DBConnect.getDbUser(), DBConnect.getDbPass());
      
      stmt = conn.createStatement();
      query = "select * from accounts where userIdentifier='" + userIdentifier + "'";
      ResultSet rs = stmt.executeQuery(query);
      
      Accounts temp = new Accounts();;
      if(rs.next()) {
          temp.setUserid(rs.getInt("userId"));
          temp.setUseridentifier(rs.getString("userIdentifier"));
          temp.setUserfname(rs.getString("userFName"));
          temp.setUserlname(rs.getString("userLName"));
          temp.setUseremail(rs.getString("userEmail"));
          temp.setUserrole(rs.getString("userRole"));
          temp.setPasswordIsEncrypted(rs.getString("password"));
          temp.setAccountstatus(rs.getInt("accountStatus"));
      }
      else {
          temp = null;
      }
            
      return temp;
    }
    catch (Exception e){
      e.printStackTrace();
      System.out.println("Caught some Exception");
      return null;
    }
    finally {
      System.out.println("In finally clause");
      if (conn != null)
        conn.close();
    }
  }
  
}
