/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.persistence;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 * 
 */
public abstract class EntityControllerBase {
   private EntityManagerFactory emf;

   protected EntityManager getEntityManager() {
      if (emf == null) {
         emf = Persistence.createEntityManagerFactory("PRJ666-ImplementationPU");
      }

      return emf.createEntityManager();
   }
}