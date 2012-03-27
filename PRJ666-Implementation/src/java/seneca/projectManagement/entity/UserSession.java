/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;
import javax.ejb.LocalBean;
import javax.ejb.Stateful;
import javax.ejb.StatefulTimeout;
import seneca.projectManagement.persistence.PersistenceController;
import seneca.projectManagement.utils.CryptoUtil;

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
  
  public Accounts getAccount(Integer id) {
    return pc.getAccount(id);
  } 
  
  public Teams getTeam(){
    return pc.getTeam( loggedUser.getUserId() );
  }
  
  public Teams getTeam(Integer id) {
    return pc.getTeam(id);
  } 
  
  public Teams getTeamById( Integer aTeamId ){
    return pc.getTeamById(aTeamId);
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
  
  public List<Teammember> getTeamMembers( Integer aTeamId ){
    return pc.getTeamMembers( aTeamId );
  }
  
  public List<Teammember> getAllMembers( Integer aTeamId ){
    return pc.getAllMembers( aTeamId );
  }
  
  public List<Teammember> getActiveTeamMembers(){
    return pc.getActiveTeamMembers();
  }
  
  public Teammember getMember( Integer aMemberId ){
    return pc.getMember(aMemberId);
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
  
  public Company getCompanyByID(Integer aCompanyID) {
      return pc.getCompanyByID( aCompanyID );
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
  
  public Projects getTeamProject( Integer aTeamId ){
    return pc.getTeamProject( aTeamId );
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
  
  public Comments getComments(Integer id) {
      return pc.getComments(id);
  }
  
  public List<Comments> getAllComments() {
      return pc.getAllComments();
  }
  
  public List<Comments> getAllComments(Integer projID) {
      List<Comments> comments = new ArrayList<Comments>();
      for(Comments c : pc.getAllComments(projID)) {
          if(c.getCommentStatus() == 0) {
              comments.add(c);
          }
      }
      return comments;
  }
  
  public List<Comments> getAllActiveComments(Integer projID) {
    List<Comments> comments = new ArrayList<Comments>();
    for(Comments c : pc.getAllComments(projID)) {
      if(c.getCommentStatus() == 1) {
        comments.add(c);
      }
    }
    return comments;
  } 
  
  public boolean updateComments(Comments aComments) {
      return pc.updateComments(aComments);
  }
  
  public List<Accounts> getAllAccounts() {
      return pc.getAllAccounts();
  }
  
  public boolean removeAccounts(Accounts a) {
    return pc.removeAccounts(a);
  }  

  public boolean updateAccounts(Accounts a) {
    return pc.updateAccounts(a);
  } 
  
  public List<Teams> getUnMatchedTeams( Integer aStatus ){
      return pc.getUnMatchedTeams(aStatus);
  }
  
  public Teams getProjectTeam(int aId){
      return pc.getProjectTeam(aId);
  }

  public boolean updateProjectFile(Projectfile aProjectfile){
      return pc.updateProjectFile(aProjectfile);
  }
  
  public boolean newComment(Comments aComment){
      return pc.newComment(aComment);
  }
  
  public boolean removeMember(Teammember aMember){
    return pc.removeMember(aMember);
  }

  //Edouard
  public boolean updateCompany(Company aCompany){
      return pc.updateCompany(aCompany);
  }
  //Edouard
  public boolean removeProjectFile(Projectfile file){
      return pc.removeProjectFile(file);
  }
  //Edouard
  public Number checkProjectComments(int id){
      return pc.checkProjectComments(id);
  }
  //Edouard
  public List<Company> getAllCompanies(){
      return pc.getAllCompanies();
  }
  //Edouard
  public List<Teams> getAllTeams(){
      return pc.getAllTeams();
  }
  
  public List<Projects> getApprovedMatchedProjects(){
    return pc.getApprovedMatchedProjects();
  }
  
  public List<News> getRecentNews(){
    return pc.getRecentNews();
  }
  
  public boolean addNewsPost( News aPost ){
    return pc.addNewsPost( aPost );
  }
}
