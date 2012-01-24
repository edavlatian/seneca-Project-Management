/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.persistence;

import javax.persistence.EntityManager;
import seneca.projectManagement.entity.Users;

/**
 *
 * @author matthewschranz
 */
public class PersistenceController extends EntityControllerBase {
  private EntityManager em;
  
  public boolean addUser (Users aUser) {
    em = getEntityManager();
    
    try {
      em.getTransaction().begin();
      em.persist(aUser);
      em.getTransaction().commit();
      return true;
    }
    catch (IllegalArgumentException e) {
      e.printStackTrace();
      System.out.println("Caught an IllegalArgumentException");
      return false;
    }
    catch (Exception e){
      e.printStackTrace();
      return false;
    }
    finally {
      System.out.println("In finally clause");
      em.close();
    }
  }
  
}
