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
 * @author Edouard
 */
public class ProjectsTest {
    private Projects p1;
    public ProjectsTest() {
    }

    @Before
    public void setUp() {
        p1 = new Projects();
        p1.setStatus("PE");
        p1.setPrjName("Test Project");        
        p1.setDescription("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.");
        p1.setPrjConstraints("List of Constraints.");
        p1.setCompanyId(3);
        p1.setInstructorId(5);
        p1.setTeamId(3);
    }
    
    @After
    public void tearDown() {
    }
    
    /**
     * Test of getStatus method, of class Projects.
     */
    @Test
    public void testGetStatus() {
        String expResult = "PE";
        String result = p1.getStatus();
        assertEquals(expResult, result);

    }

    /**
     * Test of getPrjName method, of class Projects.
     */
    @Test
    public void testGetPrjName() {
        String expResult = "Test Project";
        String result = p1.getPrjName();
        assertEquals(expResult, result);
    }

    /**
     * Test of getDescription method, of class Projects.
     */
    @Test
    public void testGetDescription() {
        String expResult = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
        String result = p1.getDescription();
        assertEquals(expResult, result);
    }

    /**
     * Test of getPrjConstraints method, of class Projects.
     */
    @Test
    public void testGetPrjConstraints() {
        String expResult = "List of Constraints.";
        String result = p1.getPrjConstraints();
        assertEquals(expResult, result);
    }

    /**
     * Test of getAgreementDate method, of class Projects.
     */
    @Test
    public void testGetAgreementDate() {
        Date expResult = new Date();
        Date result = p1.getAgreementDate();
        assertEquals(expResult, result);

    }

    /**
     * Test of getCompanyId method, of class Projects.
     */
    @Test
    public void testGetCompanyId() {
        int expResult = 3;
        int result = p1.getCompanyId();
        assertEquals(expResult, result);

    }

    /**
     * Test of getTeamId method, of class Projects.
     */
    @Test
    public void testGetTeamId() {
        Integer expResult = 3;
        Integer result = p1.getTeamId();
        assertEquals(expResult, result);

    }

    /**
     * Test of getInstructorId method, of class Projects.
     */
    @Test
    public void testGetInstructorId() {
        Integer expResult = 5;
        Integer result = p1.getInstructorId();
        assertEquals(expResult, result);

    }

}
