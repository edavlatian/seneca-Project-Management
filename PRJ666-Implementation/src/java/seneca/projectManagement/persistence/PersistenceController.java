/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.persistence;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import seneca.projectManagement.entity.Accounts;
import seneca.projectManagement.entity.Teammember;
import seneca.projectManagement.entity.Teams;

/**
 *
 * @author matthewschranz
 */
public class PersistenceController extends EntityControllerBase {

  private EntityManager em;
  
  public void addAccount( Accounts aAccount ){
    em = getEntityManager();
    
    em.getTransaction().begin();
    em.persist( aAccount );
    em.getTransaction().commit();
    em.close();
   
  }
  
  public void addTeam( Accounts aAccount ){
    addAccount( aAccount );
    
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
  }
  
  public void addTeamMember( Teammember aMember ){
    em = getEntityManager();
    em.getTransaction().begin();
    em.persist( aMember );
    em.getTransaction().commit();
    em.close();
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
  
}
