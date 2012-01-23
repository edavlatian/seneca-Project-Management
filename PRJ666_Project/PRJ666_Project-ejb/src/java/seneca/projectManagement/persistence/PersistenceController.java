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
  private static PersistenceController instance = new PersistenceController();
  
  public static synchronized PersistenceController getInstance() {
    return instance;
  }
  
  public boolean addUser (Users aUser) {
    EntityManager em = getEntityManager();
    
    try {
      em.getTransaction().begin();
      em.persist(aUser);
      em.getTransaction().commit();
      em.close();
      return true;
    }
    catch (Exception e) {
      e.printStackTrace();
      em.close();
      return false;
    }
  }
}
