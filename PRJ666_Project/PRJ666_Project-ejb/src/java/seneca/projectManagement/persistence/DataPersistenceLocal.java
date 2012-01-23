/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.persistence;

import javax.ejb.Local;

/**
 *
 * @author matthewschranz
 */
@Local
public interface DataPersistenceLocal {
  
  public boolean addUser (String aFirstName, String aLastName, String aEmail,
          String aUserIdentifier, String aUserRole, String aUserPassword);
  
}
