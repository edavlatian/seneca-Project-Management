/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import org.junit.*;
import static org.junit.Assert.*;

/**
 *
 * @author Edouard
 */
public class CommentsTest {
    
    private Comments cm1;
    
    public CommentsTest() {
    }
    
    @Before
    public void setUp() {
        cm1 = new Comments();
        cm1.setCommentStatus(0);
        cm1.setCommentDescription("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");        
        cm1.setProjectId(10);
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of getCommentStatus method, of class Comments.
     */
    @Test
    public void testGetCommentStatus() {
        Integer expResult = 0;
        Integer result = cm1.getCommentStatus();
        assertEquals(expResult, result);
    }

    /**
     * Test of getCommentDescription method, of class Comments.
     */
    @Test
    public void testGetCommentDescription() {
        String expResult = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
        String result = cm1.getCommentDescription();
        assertEquals(expResult, result);
    }

    /**
     * Test of getProjectId method, of class Comments.
     */
    @Test
    public void testGetProjectId() {
        int expResult = 10;
        int result = cm1.getProjectId();
        assertEquals(expResult, result);

    }


}
