package seneca.projectManagement.persistence;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
/**
 *
 * @author matthewschranz
 */
public abstract class EntityControllerBase {
   private EntityManagerFactory emf;

   protected EntityManager getEntityManager() {
      if (emf == null) {
         emf = Persistence.createEntityManagerFactory("PRJ666_Project-ejbPU");
      }

      return emf.createEntityManager();
   }
}