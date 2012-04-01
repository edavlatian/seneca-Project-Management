/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import org.junit.*;
import static org.junit.Assert.*;
import seneca.projectManagement.persistence.PersistenceController;

/**
 *
 * @author matthewschranz
 */
public class CompanyTest {
  
  private Company c1;
  
  public CompanyTest() {
  }
  
  @Before
  public void setUp() {
    c1 = new Company();
    c1.setBusinessAreas("Technology. Sports.");
    c1.setCompanyDescription("	Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");
    c1.setCompanyName("Herping Derping Doo");
    c1.setCompanyPhone("905-123-4567");
  }
  
  @After
  public void tearDown() {
  }

  /**
   * Test of getCompanyName method, of class Company.
   */
  @Test
  public void testGetCompanyName() {
    String expResult = "Herping Derping Doo";
    String result = c1.getCompanyName();
    assertEquals(expResult, result);
  }

  /**
   * Test of getCompanyPhone method, of class Company.
   */
  @Test
  public void testGetCompanyPhone() {
    String expResult = "905-123-4567";
    String result = c1.getCompanyPhone();
    assertEquals(expResult, result);
  }


  /**
   * Test of getBusinessAreas method, of class Company.
   */
  @Test
  public void testGetBusinessAreas() {
    String expResult = "Technology. Sports.";
    String result = c1.getBusinessAreas();
    assertEquals(expResult, result);
  }

  /**
   * Test of getCompanyDescription method, of class Company.
   */
  @Test
  public void testGetCompanyDescription() {
    String expResult = "	Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    String result = c1.getCompanyDescription();
    assertEquals(expResult, result);
  }
}
