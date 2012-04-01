/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import java.util.Date;
import org.junit.*;
import static org.junit.Assert.*;

/**
 *
 * @author matthewschranz
 */
public class NewsTest {
  
  private News n1;
  
  public NewsTest() {
  }
  
  @Before
  public void setUp() {
    n1 = new News();
    n1.setPostTitle("Derping USA");
    n1.setPostText("http://scotland.proximity.on.ca/~mjschranz/STR/chromeCurrentTime.html");
    n1.setInstructorId(5);
  }
  
  @After
  public void tearDown() {
  }

  /**
   * Test of getPostDate method, of class News.
   */
  @Test
  public void testGetPostDate() {
    Date expResult = new Date();
    Date result = n1.getPostDate();
    assertEquals(expResult, result);
  }

  /**
   * Test of getPostTitle method, of class News.
   */
  @Test
  public void testGetPostTitle() {
    String expResult = "Derping USA";
    String result = n1.getPostTitle();
    assertEquals(expResult, result);
  }

  /**
   * Test of getPostText method, of class News.
   */
  @Test
  public void testGetPostText() {
    String expResult = "http://scotland.proximity.on.ca/~mjschranz/STR/chromeCurrentTime.html";
    String result = n1.getPostText();
    assertEquals(expResult, result);
  }

  /**
   * Test of getInstructorId method, of class News.
   */
  @Test
  public void testGetInstructorId() {
    int expResult = 5;
    int result = n1.getInstructorId();
    assertEquals(expResult, result);
  }
}
