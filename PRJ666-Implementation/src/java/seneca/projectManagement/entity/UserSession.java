<<<<<<< HEAD
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import java.util.concurrent.TimeUnit;
import javax.ejb.LocalBean;
import javax.ejb.Stateful;
import javax.ejb.StatefulTimeout;
import seneca.projectManagement.persistence.PersistenceController;
import seneca.projectManagement.utils.CryptoUtil;

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
  private PersistenceController pc;
  
  public UserSession() {
    pc = new PersistenceController();
  }
  
  public Accounts getLoggedUser() {
    return loggedUser;
  }
  
  public boolean logIn( String aUserIdentifier, String aPassphrase ){
    /*
     * If a row in Accounts is found with a userIdentifier equal to aUsername
     * and the CryptoUtil.encodeBase64(CryptoUtil.digestSHA(aPassphrase)) hashed
     * password is equal then set our account member variable to the pulled down
     * account.
     */
    try {
      Accounts account = pc.getAccount( aUserIdentifier );
      if(account != null) {
        if(CryptoUtil.encodeBase64(CryptoUtil.digestSHA(aPassphrase)).equals(account.getPassword())
            == true) {
          loggedUser = account;
          return true;    
        }
      }
      else {
        loggedUser = null;
        return false;
      }
    }
    catch (Exception e){
      e.printStackTrace();
    }
    return false;
  }
  
  public boolean isLogged() {
    return loggedUser instanceof Accounts;
  }
  
  public void logout() {
    loggedUser = null;
  }
  
  public Teams getTeam(){
    return pc.getTeam( loggedUser.getUserId() );
  }
  
  public Teammember getLeader( int aTeamId ){
    return pc.getLeader( aTeamId );
  }
  
  public boolean updateMember( Teammember aMember ){
    return pc.updateMember( aMember );
  }
  
  public boolean addMember( Teammember aMember ){
    return pc.addTeamMember( aMember );
  }
  
  public boolean updateTeam( Teams aTeam ){
    return pc.updateTeam( aTeam );
  }
  
  public boolean addTeam (Accounts aAccount){
    return pc.addTeam( aAccount );
  }
  public Company getCompany(Accounts account) throws SQLException {
        try {
            conn = DriverManager.getConnection(DBConnect.getDbUrl(),
                    DBConnect.getDbUser(), DBConnect.getDbPass());

            /*
            select * from company
            where userId = 20
            */

            stmt = conn.createStatement();
            query = "select * from company "
                    + "where userId=" + account.getUserid();
            rs = stmt.executeQuery(query);

            Company comp = null;
            if(rs.next()) {
                comp = new Company();
                comp.setCompanyid(rs.getInt("companyId"));
                comp.setCompanyname(rs.getString("companyName"));
                comp.setCompanyphone(rs.getString("companyPhone"));
                comp.setRepid(rs.getInt("userId"));
            }

            return comp;
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
  
  public boolean addProject(Projects proj) throws SQLException {
        try {
            conn = DriverManager.getConnection(DBConnect.getDbUrl(),
                    DBConnect.getDbUser(), DBConnect.getDbPass());

            stmt = conn.createStatement();
            query = "INSERT INTO projects (status, prjName, description, prjConstraints, companyId)" +
                    "VALUES ('" + proj.getStatus() + "', '" + proj.getPrjname() + "', '" + proj.getDescription() + "', '" +
                    proj.getPrjconstraints() + "', " + proj.getCompanyid() + ")";
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
  
  public Projects getProject(Projects proj) throws SQLException {
        try {
            conn = DriverManager.getConnection(DBConnect.getDbUrl(),
                    DBConnect.getDbUser(), DBConnect.getDbPass());

            /*
            select * from projects
            where prjName = "Gemini"
            */

            stmt = conn.createStatement();
            query = "select * from projects "
                    + "where prjName='" + proj.getPrjname() + "'";
            rs = stmt.executeQuery(query);

            Projects value = null;
            if(rs.next()) {
                value = new Projects();
                value.setProjectid(rs.getInt("projectId"));
                value.setStatus(rs.getString("status"));
                value.setPrjname(rs.getString("prjName"));
                value.setDescription(rs.getString("description"));
                value.setPrjconstraints(rs.getString("prjConstraints"));
                value.setAgreementDate(new SimpleDateFormat("MM/dd/yyyy").format(rs.getTimestamp("agreementDate")));
                value.setCompanyid(rs.getInt("companyId"));
                value.setTeamid(rs.getInt("teamId"));
                value.setInstructorid(rs.getInt("instructorId"));
            }

            return value;
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
  
  public boolean addProjectFile(Projectfile projFile) throws SQLException {
        try {
            conn = DriverManager.getConnection(DBConnect.getDbUrl(),
                    DBConnect.getDbUser(), DBConnect.getDbPass());

            stmt = conn.createStatement();
            query = "INSERT INTO projectfile (fileName, fileDescription, theFile, projectId)" +
                    "VALUES ('" + projFile.getFilename() + "', '" + projFile.getFiledescription() + "', '" +
                    projFile.getThefile() + "', '" + projFile.getProjectid() + "')";
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
  
  public Projectfile getProfileFile(Projects proj) throws SQLException {
      try {
            conn = DriverManager.getConnection(DBConnect.getDbUrl(),
                    DBConnect.getDbUser(), DBConnect.getDbPass());

            /*
            select * from projectfile
            where projectId = 7
            */

            stmt = conn.createStatement();
            query = "select * from projectfile "
                    + "where projectId='" + proj.getProjectid() + "'";
            rs = stmt.executeQuery(query);

            Projectfile value = null;
            if(rs.next()) {
                value = new Projectfile();
                value.setFileid(rs.getInt("fileId"));
                value.setFilename(rs.getString("fileName"));
                value.setFiledescription(rs.getString("fileDescription"));
                value.setThefile(rs.getString("theFile"));
                value.setProjectid(rs.getInt("projectId"));
            }

            return value;
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
}
 