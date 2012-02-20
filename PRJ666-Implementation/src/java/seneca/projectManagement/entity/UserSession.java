/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import java.io.File;
import java.sql.*;
import java.util.ArrayList;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.LocalBean;
import javax.ejb.Stateful;
import javax.ejb.StatefulTimeout;
import seneca.projectManagement.databaseClasses.Accounts;
import seneca.projectManagement.databaseClasses.Teammember;
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
@StatefulTimeout(unit = TimeUnit.MINUTES, value = 60)
public class UserSession {

  private Accounts loggedUser;
  private Connection conn;
  private Statement stmt;
  private String query;
  private ResultSet rs;
  private Driver t;
  
  // Holds the temporary login user for checking their credentials
  private Accounts tempUser;
  private boolean isLogged ;
  private int isRegistered ;
  
  public UserSession() {
    tempUser = new Accounts();
    isLogged = false;
    isRegistered = 0;
    try {
      t = (Driver) Class.forName(DBConnect.getDriver()).newInstance();
    } catch (InstantiationException ex) {
      Logger.getLogger(UserSession.class.getName()).log(Level.SEVERE, null, ex);
    } catch (IllegalAccessException ex) {
      Logger.getLogger(UserSession.class.getName()).log(Level.SEVERE, null, ex);
    }
    catch (ClassNotFoundException ex) {
      Logger.getLogger(UserSession.class.getName()).log(Level.SEVERE, null, ex);
    }
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
      String userRole = "";
      if(loggedUser != null) {
          userRole = loggedUser.getUserrole();
      }
      return userRole;
  }
  
  public int getHasRegistered() {
      return isRegistered;
  }
  
  public int getAccountStatus() {
      return loggedUser.getAccountstatus();
  }
    
  public void logout() {
      isLogged = false;
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
            loggedUser = null;
            tempUser = null;
            value = false;
        }
      }
      catch (SQLException e) {
        System.out.println(e.getMessage());
        value = false;
      }
      return value;
  }
  
  private ArrayList<Accounts> getAccounts() throws SQLException {
      try {
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
      return null;
    }
    finally {
      if (conn != null)
        conn.close();
    }
  }
  
  private Accounts getAccounts(String userIdentifier) throws SQLException {
      try {
      conn = DriverManager.getConnection(DBConnect.getDbUrl(),
              DBConnect.getDbUser(), DBConnect.getDbPass());
      
      /*
      select * from accounts a 
      join teams t on a.userid = t.userid
      where useridentifier='PRJ566Sum2012_1'
      */
      
      stmt = conn.createStatement();
      query = "select * from accounts a "
              + "left join teams t on a.userid = t.userid "
              + "where userIdentifier='" + userIdentifier + "'";
      rs = stmt.executeQuery(query);
      
      Accounts temp = null;
      if(rs.next()) {
          temp = new Accounts();
          temp.setUserid(rs.getInt("userId"));
          temp.setUseridentifier(rs.getString("userIdentifier"));
          temp.setUserfname(rs.getString("userFName"));
          temp.setUserlname(rs.getString("userLName"));
          temp.setUseremail(rs.getString("userEmail"));
          temp.setUserrole(rs.getString("userRole"));
          temp.setPasswordIsEncrypted(rs.getString("password"));
          temp.setAccountstatus(rs.getInt("accountStatus"));
          isRegistered = rs.getInt("hasRegistered");
      }
            
      return temp;
    }
    catch (Exception e){
      e.printStackTrace();
      return null;
    }
    finally {
      if (conn != null)
        conn.close();
    }
  }
  
  public int updateTeamAccount(Teams aTeam){
    try {
      conn = DriverManager.getConnection(DBConnect.getDbUrl(),
             DBConnect.getDbUser(), DBConnect.getDbPass());
      stmt = conn.createStatement();
      query = "UPDATE teams t " +
              "SET t.teamEmail = '" + aTeam.getTeamemail() + "', t.teamStatus = " + aTeam.getTeamstatus() +
              ", t.teamName = '" + aTeam.getTeamname() + "', t.teamConstraints = '" + aTeam.getTeamconstraints() +
              "', t.teamDescription = '" + aTeam.getTeamDescription() + "', t.teamLogo = '" + aTeam.getTeamLogo() + 
              "', t.projectId = " + aTeam.getProjectid() + ", t.hasRegistered = " + aTeam.getHasregistered() + 
              ", t.userId = " + aTeam.getUserid() + " WHERE t.teamId = " + aTeam.getTeamid();
      
      return stmt.executeUpdate(query);     
    }
    catch (Exception e){
      e.printStackTrace();
    }
    finally {
      try {
        conn.close();
      } catch (SQLException ex) {
        Logger.getLogger(UserSession.class.getName()).log(Level.SEVERE, null, ex);
      }
    }
    return 0;
  }
  
  public Teams getTeamAccount(int aUserId){
    try {
      conn = DriverManager.getConnection(DBConnect.getDbUrl(),
              DBConnect.getDbUser(), DBConnect.getDbPass());
      
      stmt = conn.createStatement();
      query = "select * from teams t " +
              "left join accounts a on t.userid = a.userid " +
              "where t.userid = " + aUserId;
      rs = stmt.executeQuery(query);
      
      Teams temp = null;
      if(rs.next()){
        temp = new Teams();
        
        temp.setHasregistered(rs.getInt("hasRegistered"));
        temp.setProjectid(rs.getInt("projectId"));
        temp.setUserid(rs.getInt("userId"));
        temp.setTeamid(rs.getInt("teamId"));
        temp.setTeamLogo(rs.getString("teamLogo"));
        temp.setTeamDescription(rs.getString("teamDescription"));
        temp.setTeamconstraints(rs.getString("teamConstraints"));
        temp.setTeamname(rs.getString("teamName"));
        temp.setTeamemail(rs.getString("teamEmail"));
        temp.setTeamstatus(rs.getInt("teamStatus"));
        
        return temp;
      }
      return temp;
    }
    catch (Exception e){
      e.printStackTrace();
      return null;
    }
    finally {
      try {
        conn.close();
      } catch (SQLException ex) {
        Logger.getLogger(UserSession.class.getName()).log(Level.SEVERE, null, ex);
      }
    }
  }
  
  public Teammember getTeamMember(int aMemberId) {
    return null;
  }
  
  public Teammember getTeamLeader(int aTeamId) {
    try {
      conn = DriverManager.getConnection(DBConnect.getDbUrl(),
              DBConnect.getDbUser(), DBConnect.getDbPass());
      
      stmt = conn.createStatement();
      query = "SELECT * FROM teammember t " +
              "left JOIN teams te on t.teamId = te.teamId " +
              "where t.teamId = " + aTeamId + " AND t.teamLeader = 1";
      rs = stmt.executeQuery(query);
      
      Teammember member = null;
      if(rs.next()){
        member = new Teammember();
        member.setDescription(rs.getString("description"));
        member.setFirstname(rs.getString("firstName"));
        member.setLastname(rs.getString("lastName"));
        member.setEmail(rs.getString("email"));
        member.setImage(rs.getString("memberImage"));
        member.setTeamid(rs.getInt("teamId"));
        member.setTeamleader(rs.getInt("teamLeader"));
        member.setMemberid(rs.getInt("memberId"));
      }
      
      return member;
    }
    catch (Exception e) {
      e.printStackTrace();
      return null;
    }
    finally {
      try {
        conn.close();
      } catch (SQLException ex) {
        Logger.getLogger(UserSession.class.getName()).log(Level.SEVERE, null, ex);
      }
    }
  }
  
  public int updateTeamMember(Teammember aMember){
    try {
      conn = DriverManager.getConnection(DBConnect.getDbUrl(),
              DBConnect.getDbUser(), DBConnect.getDbPass());
      
      stmt = conn.createStatement();
      query = "UPDATE teammember t " +
              "SET t.firstName = '" + aMember.getFirstname() + "', t.lastName = '" + aMember.getLastname() +
              "', t.email = '" + aMember.getEmail() + "', t.memberImage = '" + aMember.getImage() +
              "', t.description = '" + aMember.getDescription() + "', t.teamLeader = " + aMember.getTeamleader() +
              ", t.teamId = " + aMember.getTeamid() + " WHERE t.memberId = " + aMember.getMemberid();
      
      return stmt.executeUpdate(query);
    }
    catch (Exception e){
      e.printStackTrace();
      return 0;
    }
    finally {
      try {
        conn.close();
      } catch (SQLException ex) {
        Logger.getLogger(UserSession.class.getName()).log(Level.SEVERE, null, ex);
      }
    }
  }
  
  public boolean addTeamMember(Teammember aMember){
    try {
      conn = DriverManager.getConnection(DBConnect.getDbUrl(),
              DBConnect.getDbUser(), DBConnect.getDbPass());
      
      stmt = conn.createStatement();
      query = "INSERT INTO teammember (firstName, lastName, email, memberImage, description, teamLeader, teamId)" +
              "VALUES ('" + aMember.getFirstname() + "', '" + aMember.getLastname() + "', '" + aMember.getEmail() + "', '" +
              aMember.getImage() + "', '" + aMember.getDescription() + "', " + aMember.getTeamleader() + ", " +
              aMember.getTeamid() + ")";
      
      return stmt.executeUpdate(query) == 1 ? true : false;
    }
    catch (Exception e) {
      e.printStackTrace();
      return false;
    }
    finally {
      try {
        conn.close();
      } catch (SQLException ex) {
        Logger.getLogger(UserSession.class.getName()).log(Level.SEVERE, null, ex);
      }
    }
  }
}
