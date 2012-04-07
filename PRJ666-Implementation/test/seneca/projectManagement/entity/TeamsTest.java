/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import static org.junit.Assert.assertEquals;
import org.junit.*;

/**
 *
 * @author KepneR
 */
public class TeamsTest {
    private Teams valid;
    
    public TeamsTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
    }
    
    @Before
    public void setUp() {
        valid = new Teams();
        valid.setHasRegistered(0);
        valid.setTeamConstraints("JAVA, MYSQL, GLASSFISH, JSP");
        valid.setTeamDescription("Sample description for the team");
        valid.setTeamEmail("klcaliso1@learn.sencac.on.ca;klcaliso1@senecacollege.ca");
        valid.setTeamLogo("http://www.senecacollege.ca");
        valid.setTeamName("PRJ666 Team");
        valid.setTeamStatus(0);
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of getTeamEmail method, of class Teams.
     */
    @Test
    public void testGetTeamEmail() {
        System.out.println("getTeamEmail");
        String expResult = "klcaliso1@learn.sencac.on.ca;klcaliso1@senecacollege.ca";
        String result = valid.getTeamEmail();
        assertEquals(expResult, result);
    }

    /**
     * Test of setTeamEmail method, of class Teams.
     */
    @Test
    public void testSetTeamEmail() {
        System.out.println("setTeamEmail");
        String expResult = "klcaliso1@senecacollege.ca;klcaliso1@learn.sencac.on.ca";
        valid.setTeamEmail(expResult);
        String result = valid.getTeamEmail();
        assertEquals(expResult, result);
    }

    /**
     * Test of getTeamStatus method, of class Teams.
     */
    @Test
    public void testGetTeamStatus() {
        System.out.println("getTeamStatus");
        Integer expResult = 0;
        Integer result = valid.getTeamStatus();
        assertEquals(expResult, result);
    }

    /**
     * Test of setTeamStatus method, of class Teams.
     */
    @Test
    public void testSetTeamStatus() {
        System.out.println("setTeamStatus");
        Integer expResult = 1;
        valid.setTeamStatus(expResult);
        Integer result = valid.getTeamStatus();
        assertEquals(expResult, result);
    }

    /**
     * Test of getTeamName method, of class Teams.
     */
    @Test
    public void testGetTeamName() {
        System.out.println("getTeamName");
        String expResult = "PRJ666 Team";
        String result = valid.getTeamName();
        assertEquals(expResult, result);
    }

    /**
     * Test of setTeamName method, of class Teams.
     */
    @Test
    public void testSetTeamName() {
        System.out.println("setTeamName");
        String expResult = "PRJ666 NEW Team";
        valid.setTeamName(expResult);
        String result = valid.getTeamName();
        assertEquals(expResult, result);
    }

    /**
     * Test of getTeamConstraints method, of class Teams.
     */
    @Test
    public void testGetTeamConstraints() {
        System.out.println("getTeamConstraints");
        String expResult = "JAVA, MYSQL, GLASSFISH, JSP";
        String result = valid.getTeamConstraints();
        assertEquals(expResult, result);
    }

    /**
     * Test of setTeamConstraints method, of class Teams.
     */
    @Test
    public void testSetTeamConstraints() {
        System.out.println("setTeamConstraints");
        String expResult = "JAVA, MYSQL, GLASSFISH, JSP, C#, ASP.NET";
        valid.setTeamConstraints(expResult);
        String result = valid.getTeamConstraints();
        assertEquals(expResult, result);
    }

    /**
     * Test of getTeamDescription method, of class Teams.
     */
    @Test
    public void testGetTeamDescription() {
        System.out.println("getTeamDescription");
        String expResult = "Sample description for the team";
        String result = valid.getTeamDescription();
        assertEquals(expResult, result);
    }

    /**
     * Test of setTeamDescription method, of class Teams.
     */
    @Test
    public void testSetTeamDescription() {
        System.out.println("setTeamDescription");
        String expResult = "Sample description for the team";
        valid.setTeamDescription(expResult);
        String result = valid.getTeamDescription();
        assertEquals(expResult, result);
    }

    /**
     * Test of getTeamLogo method, of class Teams.
     */
    @Test
    public void testGetTeamLogo() {
        System.out.println("getTeamLogo");
        String expResult = "http://www.senecacollege.ca";
        String result = valid.getTeamLogo();
        assertEquals(expResult, result);
    }

    /**
     * Test of setTeamLogo method, of class Teams.
     */
    @Test
    public void testSetTeamLogo() {
        System.out.println("setTeamLogo");
        String expResult = "http://www.senecacollege.ca";
        valid.setTeamLogo(expResult);
        String result = valid.getTeamLogo();
        assertEquals(expResult, result);
    }

    /**
     * Test of getHasRegistered method, of class Teams.
     */
    @Test
    public void testGetHasRegistered() {
        System.out.println("getHasRegistered");
        Integer expResult = 0;
        Integer result = valid.getHasRegistered();
        assertEquals(expResult, result);
    }

    /**
     * Test of setHasRegistered method, of class Teams.
     */
    @Test
    public void testSetHasRegistered() {
        System.out.println("setHasRegistered");
        Integer expResult = 1;
        valid.setHasRegistered(expResult);
        Integer result = valid.getHasRegistered();
        assertEquals(expResult, result);
    }
}
