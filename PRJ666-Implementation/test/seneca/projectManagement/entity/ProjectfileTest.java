/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import org.junit.*;
import static org.junit.Assert.*;

/**
 *
 * @author matthewschranz
 */
public class ProjectfileTest {
  
  private Projectfile pf1;
  
  public ProjectfileTest() {
  }
  
  @Before
  public void setUp() {
    pf1 = new Projectfile();
    pf1.setFileName("This-is-a_Test");
    pf1.setFileDescription("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");
    pf1.setProjectId(5);
    pf1.setTheFile("http://scotland.proximity.on.ca/~mjschranz/STR/chromeCurrentTime.html");
  }
  
  @After
  public void tearDown() {
  }

  /**
   * Test of getFileName method, of class Projectfile.
   */
  @Test
  public void testGetFileName() {
    String expResult = "This-is-a_Test";
    String result = pf1.getFileName();
    assertEquals(expResult, result);
  }

  /**
   * Test of getFileDescription method, of class Projectfile.
   */
  @Test
  public void testGetFileDescription() {
    String expResult = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    String result = pf1.getFileDescription();
    assertEquals(expResult, result);
  }

  /**
   * Test of getTheFile method, of class Projectfile.
   */
  @Test
  public void testGetTheFile() {
    String expResult = "http://scotland.proximity.on.ca/~mjschranz/STR/chromeCurrentTime.html";
    String result = pf1.getTheFile();
    assertEquals(expResult, result);
  }

  /**
   * Test of getProjectId method, of class Projectfile.
   */
  @Test
  public void testGetProjectId() {
    int expResult = 5;
    int result = pf1.getProjectId();
    assertEquals(expResult, result);
  }
}
