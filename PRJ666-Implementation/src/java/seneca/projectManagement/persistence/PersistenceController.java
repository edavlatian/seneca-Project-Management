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
    
    em.getTransaction().begin();
    em.persist( aAccount );
    em.getTransaction().commit();
    em.close();
  
    return true;
  }
  
  public boolean addTeam( Accounts aAccount ){
    boolean result = addAccount( aAccount );
    
    if( result ){
      Teams team = new Teams();
      Accounts account = getAccount( aAccount.getUserIdentifier() );
      team.setUserId( account.getUserId() );
      team.setTeamEmail( account.getUserEmail() );
    
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
  
  public Accounts getAccount( String aUserIdentifier ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "Accounts.findByUserIdentifier" ).setParameter( "userIdentifier", 
            aUserIdentifier );
    
    return (Accounts) q.getSingleResult();
  }
  
  public Teammember getLeader( int aTeamId ){
    em = getEntityManager();
    
    Query q = em.createQuery("SELECT t FROM Teammember t WHERE t.teamId = :teamId AND t.teamLeader = 1")
            .setParameter("teamId", aTeamId);
    
    return (Teammember) q.getSingleResult();
  }
  
  public List<Teammember> getAllTeamMembers( Integer aTeamId ){
    em = getEntityManager();
    
    Query q = em.createQuery( "SELECT t FROM Teammember t where t.teamId = :teamId AND t.teamLeader = 0" )
            .setParameter( "teamId", aTeamId );
    
    return (List<Teammember>)q.getResultList();
  }
  
  public boolean updateMember( Teammember aMember ){
    em = getEntityManager();
    
    em.getTransaction().begin();
    em.merge( aMember );
    em.getTransaction().commit();

    em.close();
    
    return true;
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
    
    return (Projects) q.getSingleResult();
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
  
  public List<Projects> getAvailableProjects( String aStatus ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "SELECT p FROM projects p WHERE p.status = :status ORDER BY p.projectId ASC")
            .setParameter( "status", aStatus );
    
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
  
  public List<Milestone> getProjectMilestones( Integer aProjectId ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "Milestone.findByProjectId" )
            .setParameter( "projectId", aProjectId );
    
    return (List<Milestone>)q.getResultList();
  }

  public boolean newMilestone( Milestone aMilestone ){
    em = getEntityManager();
    
    em.getTransaction().begin();
    em.persist( aMilestone );
    em.getTransaction().commit();
    
    em.close();
    
    return true;
  }
  
  public Milestone getMilestone( Integer aMilestoneId ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "Milestone.findByMilestoneId" )
            .setParameter( "milestoneId", aMilestoneId );
    
    return (Milestone)q.getSingleResult();
  }
  
  public boolean updateMilestone( Milestone aMilestone ){
    em = getEntityManager();
    
    em.getTransaction().begin();
    em.merge( aMilestone );
    em.getTransaction().commit();
    
    em.close();
    
    return true;
  }
  
  public List<Teamprojectranking> getTeamProjectRankings( Integer aTeamId ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "SELECT m from Teamprojectranking m WHERE m.teamId = :teamId ORDER BY m.projectId ASC")
            .setParameter( "teamId", aTeamId );
    
    return (List<Teamprojectranking>) q.getResultList();
  }
  
  public Number countSemesterTeams( String aPeriod ){
    em = getEntityManager();
    
    Query q = em.createQuery( "SELECT COUNT(a.userIdentifier) FROM Accounts a WHERE a.userIdentifier LIKE :period ")
            .setParameter( "period", "%" + aPeriod + "%" );
    
    return (Number)q.getSingleResult();
  }
  
  //Edouard
  public List<Teams> getAvailableTeams(int aStatus){
      em = getEntityManager();
      
      Query q = em.createNamedQuery("Teams.findByTeamStatus")
              .setParameter( "teamStatus", aStatus );
      
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
  /*
  public List<Milestone> getUpcomingMilestones(){
      em = getEntityManager();

      Query q = em.createQuery( "SELECT m FROM Milestone m WHERE m.dueDate >= '2012-03-05' AND m.dueDate <= '2012-04-05' ");

      return (List<Milestone>)q.getResultList();
  }*/
  
}
