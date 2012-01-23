/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.persistence;

import javax.ejb.Stateless;
import seneca.projectManagement.entity.Users;

/**
 *
 * @author matthewschranz
 */
@Stateless
public class DataPersistence implements DataPersistenceLocal {
  private PersistenceController persistence;
  
  public DataPersistence() {
    persistence = PersistenceController.getInstance(); 
  }

  @Override
  public boolean addUser(String aFirstName, String aLastName, String aEmail, String aUserIdentifier, String aUserRole, String aUserPassphrase) {
    Users newUser = new Users(aFirstName, aLastName, aEmail, aUserIdentifier,
            aUserRole, aUserPassphrase);
    
    return persistence.addUser(newUser);
    
  }
  
}
