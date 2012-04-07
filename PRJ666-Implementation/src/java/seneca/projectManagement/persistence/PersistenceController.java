/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.persistence;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import seneca.projectManagement.entity.*;

/**
 *
 * @author matthewschranz
 */
public class PersistenceController extends EntityControllerBase {

  private EntityManager em;
  
  public boolean addAccount( Accounts aAccount ){
    em = getEntityManager();
    
    try{
      em.getTransaction().begin();
      em.persist( aAccount );
      em.getTransaction().commit();
      em.close();
      return true;
    } catch (Exception e) {
      e.printStackTrace();
      return false;
    }
  }
  
  public boolean addTeam( Accounts aAccount ){
    boolean result = addAccount( aAccount );
    
    if( result ){
      Teams team = new Teams();
      Accounts account = getAccount( aAccount.getUserIdentifier() );
      team.setUserId( account.getUserId() );
      team.setTeamEmail( account.getUserEmail() );
      team.setTeamName("Unregistered Team. User Id: " + account.getUserId());
    
      em = getEntityManager();
      em.getTransaction().begin();
      em.persist( team );
      em.getTransaction().commit();
      em.close();
    
      team = getTeam( account.getUserId() );
    
      Teammember member = new Teammember();
      member.setEmail( account.getUserEmail() );
      member.setFirstName( account.getUserFName() );
      member.setLastName( account.getUserLName() );
      member.setTeamId( team.getTeamId() );
      member.setTeamLeader( 1 );
    
      addTeamMember( member );
      
      return true;
    }
    return false;
  }
  
  public boolean addTeamMember( Teammember aMember ){
    em = getEntityManager();
    em.getTransaction().begin();
    em.persist( aMember );
    em.getTransaction().commit();
    em.close();
    
    return true;
  }
  
  public Teams getTeam( Integer userId ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "Teams.findByUserId" ).setParameter( "userId", userId );
    
    return (Teams) q.getSingleResult();
  }
  
  public Teams getTeamById( Integer aTeamId ){
    em = getEntityManager();
    
    em.getTransaction().begin();
    return em.find(Teams.class, aTeamId);
  }
  
  public Accounts getAccount( String aUserIdentifier ){
    Accounts value = null;
    try {
        em = getEntityManager();
        Query q = em.createNamedQuery( "Accounts.findByUserIdentifier" ).setParameter( "userIdentifier", 
                aUserIdentifier );
        value = (Accounts) q.getSingleResult();
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    return value;
  }
  
  public Accounts getAccount(Integer id) {
    em = getEntityManager();   
    em.getTransaction().begin();
    
    return em.find(Accounts.class, id);
  } 
  
  public Teammember getLeader( int aTeamId ){
    try{
      em = getEntityManager();
    
      Query q = em.createQuery("SELECT t FROM Teammember t WHERE t.teamId = :teamId AND t.teamLeader = 1")
              .setParameter("teamId", aTeamId);
    
      return (Teammember) q.getSingleResult();
    }
    catch (Exception e){
      return null;
    }
  }
  
  public List<Teammember> getTeamMembers( Integer aTeamId ){
    em = getEntityManager();
    
    Query q = em.createQuery( "SELECT t FROM Teammember t where t.teamId = :teamId AND t.teamLeader = 0" )
            .setParameter( "teamId", aTeamId );
    
    return (List<Teammember>)q.getResultList();
  }
  
  public List<Teammember> getAllMembers( Integer aTeamId ){
    em = getEntityManager();
    
    Query q = em.createQuery( "SELECT t FROM Teammember t where t.teamId = :teamId" )
            .setParameter( "teamId", aTeamId );
    
    return (List<Teammember>)q.getResultList();
  }
  
  public List<Teammember> getActiveTeamMembers(){
    em = getEntityManager();
    
    Query q = em.createNamedQuery("Teams.findByTeamStatus").setParameter("teamStatus", 1);
    
    List<Teams> tms = (List<Teams>)q.getResultList();
    Teams t = null;
    
    List<Teammember> tmbrs = null, temp = null;
    Teammember m = null;
    
    q = em.createNamedQuery("Teammember.findByTeamId").setParameter("teamId", tms.get(0).getTeamId());
    tmbrs = (List<Teammember>)q.getResultList();
    
    for(int i = 1, len = tms.size(); i < len; i++){
      t = tms.get(i);
      q = em.createNamedQuery("Teammember.findByTeamId").setParameter("teamId", t.getTeamId());
      
      temp = (List<Teammember>)q.getResultList();
      
      for(int k = 0, len2 = temp.size(); k < len2; k++){
        tmbrs.add(temp.get(k));
      } 
    }
    
    return tmbrs;
  }
  
  public List<Teammember> getActiveRegisteredTeamMembers(){
    em = getEntityManager();
    
    Query q = em.createQuery("SELECT t FROM Teams t WHERE t.teamStatus = 1 AND t.hasRegistered = 1");
    
    List<Teams> tms = (List<Teams>)q.getResultList();
    Teams t = null;
    
    List<Teammember> tmbrs = null, temp = null;
    Teammember m = null;
    
    q = em.createNamedQuery("Teammember.findByTeamId").setParameter("teamId", tms.get(0).getTeamId());
    tmbrs = (List<Teammember>)q.getResultList();
    
    for(int i = 1, len = tms.size(); i < len; i++){
      t = tms.get(i);
      q = em.createNamedQuery("Teammember.findByTeamId").setParameter("teamId", t.getTeamId());
      
      temp = (List<Teammember>)q.getResultList();
      
      for(int k = 0, len2 = temp.size(); k < len2; k++){
        tmbrs.add(temp.get(k));
      } 
    }
    return tmbrs;
  }
  
  public boolean updateMember( Teammember aMember ){
    em = getEntityManager();
    
    em.getTransaction().begin();
    em.merge( aMember );
    em.getTransaction().commit();

    em.close();
    
    return true;
  }
  
  public Teammember getMember( Integer aMemberId ){
    em = getEntityManager();
    
    em.getTransaction().begin();
    return em.find(Teammember.class, aMemberId);
  }
  
  public boolean updateTeam( Teams aTeam ){
    em = getEntityManager();
    
    em.getTransaction().begin();
    em.merge( aTeam );
    em.getTransaction().commit();

    em.close();
    
    return true;
  }
  
  public Company getCompany( Integer aUserId ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery("Company.findByUserId")
            .setParameter("userId", aUserId);
    
    return (Company)q.getSingleResult();
  }
  
  public Company getCompanyByID(Integer aCompanyID) {
      em = getEntityManager();
      return em.find(Company.class, aCompanyID);
  }
  
  public boolean addCompany( Company aCompany ){
    em = getEntityManager();
    
    em.getTransaction().begin();
    em.persist( aCompany );
    em.getTransaction().commit();
    
    em.close();
    
    return true;
  }
  
  public boolean addProject( Projects aProject ){
    em = getEntityManager();
    
    em.getTransaction().begin();
    em.persist( aProject );
    em.getTransaction().commit();
    
    em.close();
    
    return true;
  }
  
  public Projects getProject( Projects aProject ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery("Projects.findByPrjName")
            .setParameter("prjName", aProject.getPrjName());
    Projects value = null;
    try {
        value = (Projects) q.getSingleResult();
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    return value;
  }
  
  public Projects getProject( String pname ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery("Projects.findByPrjName")
            .setParameter("prjName", pname);
    Projects value = null;
    try {
        value = (Projects) q.getSingleResult();
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    return value;
  }
  
  public Projects getProject( Integer id ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery("Projects.findByProjectId")
            .setParameter("projectId", id);
    
    return (Projects) q.getSingleResult();
  }
  
  public boolean addProjectFile( Projectfile aProjectFile ){
    em = getEntityManager();
    
    em.getTransaction().begin();
    em.persist( aProjectFile );
    em.getTransaction().commit();
    
    em.close();
    
    return true;
  }
  
  public Projects getTeamProject( Integer aTeamId ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery("Projects.findByTeamId")
            .setParameter( "teamId", aTeamId );
    try {
      return (Projects) q.getSingleResult();
    } catch (Exception e) {
      return null; 
    }
  }
  
  public List<Projectfile> getProjectFiles( Integer aProjectId ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery("Projectfile.findByProjectId")
            .setParameter("projectId", aProjectId);
    
    return (List<Projectfile>)q.getResultList();
  }
  
  public Projectfile getAProjectFile( Integer aFileId ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "Projectfile.findByFileId")
            .setParameter( "fileId", aFileId );
    
    return (Projectfile) q.getSingleResult();
  }
  
  public List<Projects> getAllProjects() {
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "Projects.findAll" );
    
    return (List<Projects>) q.getResultList();
  }
  
  public List<Projects> getAllProjects(String status) {
      em = getEntityManager();
    
    Query q = em.createNamedQuery( "Projects.findByStatus" ).setParameter("status", status);
    
    return (List<Projects>) q.getResultList();
  }
  
  public List<Projects> getCompanyProjects( Integer aCompanyId ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "Projects.findByCompanyId" )
            .setParameter( "companyId", aCompanyId );
    
    return (List<Projects>)q.getResultList();
  }

  public List<Projects> getInstructorProjects( Integer aInstructorId ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "Projects.findByInstructorId" )
            .setParameter( "instructorId", aInstructorId );
    
    return (List<Projects>)q.getResultList();
  }
  
  public boolean updateProject(Projects p) {
    em = getEntityManager();

    em.getTransaction().begin();
    em.merge( p );
    em.getTransaction().commit();

    em.close();

    return true;
  }
  
  public Number countSemesterTeams( String aPeriod ){
    em = getEntityManager();
    
    Query q = em.createQuery( "SELECT COUNT(a.userIdentifier) FROM Accounts a WHERE a.userIdentifier LIKE :period ")
            .setParameter( "period", "%" + aPeriod + "%" );
    
    return (Number)q.getSingleResult();
  }

  public Comments getComments(Integer id) {
    em = getEntityManager();
    
    Query q = em.createNamedQuery("Comments.findByCommentId")
            .setParameter("commentId", id);
    
    return (Comments) q.getSingleResult();
  }
  
  public List<Comments> getAllComments() {
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "Comments.findAll" );
    
    return (List<Comments>) q.getResultList();
  }
  
  public List<Comments> getAllComments(Integer projID) {
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "Comments.findByProjectId" ).setParameter("projectId", projID);
    
    return (List<Comments>) q.getResultList();
  }
  
  public boolean updateComments( Comments aComments ){
    em = getEntityManager();
    
    em.getTransaction().begin();
    em.merge( aComments );
    em.getTransaction().commit();
    
    em.close();
    
    return true;
  }
  
  public List<Accounts> getAllAccounts() {
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "Accounts.findAll" );
    
    return (List<Accounts>) q.getResultList();
  }
  
  //Edouard
  public List<Teams> getUnMatchedTeams( ){
      em = getEntityManager();
      
      Query q = em.createQuery("SELECT t FROM Teams t WHERE t.projectId IS NULL AND t.teamStatus = 1 AND t.hasRegistered = 1");
      
      return (List<Teams>)q.getResultList();
  } 
  
  public Teams getProjectTeam(int aId){
      em = getEntityManager();
      try{
        Query q = em.createNamedQuery("Teams.findByProjectId");
        q.setParameter( "projectId", aId );
        return (Teams)q.getSingleResult();
      }catch(Exception e ){
          return null;
      }
  }
  
  public boolean updateProjectFile( Projectfile aProjectfile){
    em = getEntityManager();
    
    em.getTransaction().begin();
    em.merge( aProjectfile );
    em.getTransaction().commit();
    
    em.close();
    
    return true;
  }
  
  public boolean newComment( Comments aComment){
    em = getEntityManager();
    
    em.getTransaction().begin();
    em.merge( aComment );
    em.getTransaction().commit();
    
    em.close();
    
    return true;
  }
  
  public boolean removeAccounts(Accounts a) {
      boolean ret = false;
      em = getEntityManager();
      try {
          em.getTransaction().begin();
          em.remove(em.merge(a));
          em.getTransaction().commit();
          ret = true;
      } catch (Exception e) {
          e.printStackTrace();
      }
      em.close();
      return ret;
  }
  
  public boolean updateAccounts(Accounts a) {
        boolean ret = false;
        em = getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge( a );
            em.getTransaction().commit();
            em.close();
            ret = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return ret;
  }
  
  public boolean removeMember( Teammember aMember ){
    em = getEntityManager();
    
    em.getTransaction().begin();
    em.remove(em.merge(aMember));
    em.getTransaction().commit();
    em.close();
    
    return true;
  }

//Edouard
  public boolean updateCompany(Company aCompany){
    boolean ret = false;
    em = getEntityManager();
    try{
        em.getTransaction().begin();
        em.merge( aCompany );
        em.getTransaction().commit();
        em.close();
        ret = true;
    } catch (Exception e){
        e.printStackTrace();
    }
    return ret;
  }
//Edouard
  public boolean removeProjectFile(Projectfile file) {
      boolean ret = false;
      em = getEntityManager();
      try {
          em.getTransaction().begin();
          em.remove(em.merge(file));
          em.getTransaction().commit();
          ret = true;
      } catch (Exception e) {
          e.printStackTrace();
      }
      em.close();
      return ret;
  }
  //Edouard
  public Number checkProjectComments(int id){
      em = getEntityManager();
      Query q = em.createQuery( "SELECT COUNT(a.projectId) FROM Comments a WHERE a.projectId=:id ")
            .setParameter( "id", id );

      return (Number)q.getSingleResult();
  }
  //Edouard
  public List<Company> getAllCompanies(){
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "Company.findAll" );
    
    return (List<Company>) q.getResultList();
  }
  //Edouard
  public List<Teams> getAllTeams(){
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "Teams.findAll" );
    
    return (List<Teams>) q.getResultList();
  }
  
  public List<Projects> getApprovedMatchedProjects(){
    em = getEntityManager();
    
    Query q = em.createQuery( "Select p FROM Projects p WHERE p.status = 'MA' OR p.status = 'AP'");
    
    return q.getResultList() != null ? (List<Projects>)q.getResultList() : null;
  }
  
  public List<News> getRecentNews(){
    em = getEntityManager();
    
    Query q = em.createQuery( "SELECT n FROM News n ORDER BY n.postDate DESC" );
    q.setMaxResults(5);
    
    return (List<News>)q.getResultList();
  }
  
  public boolean addNewsPost( News aPost ){
    em = getEntityManager();
    
    em.getTransaction().begin();
    em.persist(aPost);
    em.getTransaction().commit();
    
    em.close();
    
    return true;
  }

  //Edouard
  public boolean removeProject(Projects aProject) {
    boolean ret = false;
    em = getEntityManager();
    try {
      em.getTransaction().begin();
      em.remove(em.merge(aProject));
      em.getTransaction().commit();
      ret = true;
    } catch (Exception e) {
      e.printStackTrace();
    }
    em.close();
    return ret;
  }
}
