/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.persistence;

import java.util.ArrayList;
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
    
    
    return (Teams)q.getSingleResult();
  }
  
  public Accounts getAccount( String aUserIdentifier ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "Accounts.findByUserIdentifier" ).setParameter( "userIdentifier", 
            aUserIdentifier );
    
    return (Accounts)q.getSingleResult();
  }
  
  public Teammember getLeader( int aTeamId ){
    em = getEntityManager();
    
    Query q = em.createQuery("SELECT t FROM Teammember t WHERE t.teamId = :teamId AND t.teamLeader = 1")
            .setParameter("teamId", aTeamId);
    
    return (Teammember)q.getSingleResult();
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
    
    Query q = em.createNamedQuery("Company.findByUserId").setParameter("userId", aUserId);
    
    return (Company)q.getSingleResult();
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
    
    return (Projects)q.getSingleResult();
  }
  
  public boolean addProjectFile( Projectfile aProjectFile ){
    em = getEntityManager();
    
    em.getTransaction().begin();
    em.persist( aProjectFile );
    em.getTransaction().commit();
    
    em.close();
    
    return true;
  }
  
  public ArrayList<Projectfile> getProjectFiles( Integer aProjectId ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery("Projectfile.findByProjectId")
            .setParameter("projectId", aProjectId);
    
    return (ArrayList<Projectfile>)q.getResultList();
  }
  
  public Projectfile getAProjectFile( Integer aFileId ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "Projectfile.findByFileId")
            .setParameter( "fileId", aFileId );
    
    return (Projectfile)q.getSingleResult();
  }
  
  public ArrayList<Projects> getCompanyProjects( Integer aCompanyId ){
    em = getEntityManager();
    
    Query q = em.createNamedQuery( "Projects.findByCompanyId" )
            .setParameter( "companyId", aCompanyId );
    
    return (ArrayList<Projects>)q.getResultList();
  }
}
