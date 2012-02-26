/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;
import javax.ejb.LocalBean;
import javax.ejb.Stateful;
import javax.ejb.StatefulTimeout;
import seneca.projectManagement.persistence.PersistenceController;
import seneca.projectManagement.utils.CryptoUtil;
import seneca.projectManagement.utils.Validation;
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

  private Accounts loggedUser = null;
  private PersistenceController pc = null;
  
  public UserSession() {
    pc = new PersistenceController();
    loggedUser = null;
  }
  
  public Accounts getLoggedUser() {
    return loggedUser;
  }

  public void setLoggedUser(Accounts loggedUser) {
    this.loggedUser = loggedUser;
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
            == true && account.getAccountStatus() == 1) {
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
  
  public boolean addAccount( Accounts aAccount ){
    return pc.addAccount( aAccount );
  }
  
  public Accounts getAccount(String userIdentifier) {
      return pc.getAccount(userIdentifier);
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
  
  public Company getCompany(){
    return pc.getCompany( loggedUser.getUserId() );
  }
  
  public Company getCompanyByID(Integer companyID) {
      return pc.getCompanyByID(companyID);
  }
  
  public boolean addCompany( Company aCompany ){
    return pc.addCompany( aCompany );
  }
  
  public boolean addProject(Projects proj){
    return pc.addProject( proj );
  }
  
  public Projects getProject(Projects proj){
    return pc.getProject( proj );
  }
  
  public Projects getProject(String pname){
    return pc.getProject( pname );
  }
  
  public Projects getProject(Integer id){
    return pc.getProject( id );
  }  
  
  public boolean addProjectFile(Projectfile projFile){
    return pc.addProjectFile( projFile );
  }
  
  public List<Projectfile> getProfileFiles(Integer aProjectId){
    return pc.getProjectFiles( aProjectId );
  }
  
  public Projectfile getAProjectFile( Integer aFileId ){
    return pc.getAProjectFile( aFileId );
  }
  
  public List<Projects> getAllProjects(){
    return pc.getAllProjects();
  }
  
  public List<Projects> getAllProjects(String status) {
      return pc.getAllProjects(status);
  }
  
  public List<Projects> getAllProjects(String status, Accounts a) {
      List<Projects> value = new ArrayList<Projects>();
      for(Projects p : pc.getAllProjects(status)) {
          if(p.getInstructorId() == a.getUserId()) {
              value.add(p);
          }
      }
      return value;
  }
  
  public List<Projects> getAllProjects(String status, String sem) {
      List<Projects> value = new ArrayList<Projects>();
      for(Projects p : pc.getAllProjects(status)) {
          if(p.getPrjIdentifier() != null) {
            if(p.getPrjIdentifier().equals(sem) == true) {
                value.add(p);
            }
          }
      }
      return value;
  }
  
  public List<Projects> getCompanyProjects( Company aCompany ){
    return pc.getCompanyProjects( aCompany.getCompanyId() );
  }
  
  public List<Projects> getInstructorProjects( Accounts aAccount ){
    return pc.getCompanyProjects( aAccount.getUserId() );
  }
  
  public boolean updateProject(Projects p) {
      return pc.updateProject(p);
  }
}
 