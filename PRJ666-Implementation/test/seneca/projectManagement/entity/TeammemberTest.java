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
public class TeammemberTest {
    private Teammember v;
    
    public TeammemberTest() {
    }

    @BeforeClass
    public static void setUpClass() throws Exception {
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
    }
    
    @Before
    public void setUp() {
        v = new Teammember();
        v.setDescription("Sample description for Teammember");
        v.setEmail("klcaliso1@learn.senecac.on.ca");
        v.setFirstName("Kepner");
        v.setLastName("Caliso");
        v.setMemberImage("http://www.senecacollege.ca");
    }
    
    @After
    public void tearDown() {
    }

    /**
     * Test of getFirstName method, of class Teammember.
     */
    @Test
    public void testGetFirstName() {
        System.out.println("getFirstName");
        String expResult = "Kepner";
        String result = v.getFirstName();
        assertEquals(expResult, result);
    }

    /**
     * Test of setFirstName method, of class Teammember.
     */
    @Test
    public void testSetFirstName() {
        System.out.println("setFirstName");
        String expResult = "Caliso";
        v.setFirstName(expResult);
        String result = v.getFirstName();
        assertEquals(expResult, result);
    }

    /**
     * Test of getLastName method, of class Teammember.
     */
    @Test
    public void testGetLastName() {
        System.out.println("getLastName");
        String expResult = "Caliso";
        String result = v.getLastName();
        assertEquals(expResult, result);
    }

    /**
     * Test of setLastName method, of class Teammember.
     */
    @Test
    public void testSetLastName() {
        System.out.println("setLastName");
        String expResult = "Kepner";
        v.setLastName(expResult);
        String result = v.getLastName();
        assertEquals(expResult, result);
    }

    /**
     * Test of getEmail method, of class Teammember.
     */
    @Test
    public void testGetEmail() {
        System.out.println("getEmail");
        String expResult = "klcaliso1@learn.senecac.on.ca";
        String result = v.getEmail();
        assertEquals(expResult, result);
    }

    /**
     * Test of setEmail method, of class Teammember.
     */
    @Test
    public void testSetEmail() {
        System.out.println("setEmail");
        String expResult = "kepner.caliso@senecacollege.ca";
        v.setEmail(expResult);
        String result = v.getEmail();
        assertEquals(expResult, result);
    }

    /**
     * Test of getMemberImage method, of class Teammember.
     */
    @Test
    public void testGetMemberImage() {
        System.out.println("getMemberImage");
        String expResult = "http://www.senecacollege.ca";
        String result = v.getMemberImage();
        assertEquals(expResult, result);
    }

    /**
     * Test of setMemberImage method, of class Teammember.
     */
    @Test
    public void testSetMemberImage() {
        System.out.println("setMemberImage");
        String expResult = "http://www.senecacollege.ca";
        v.setMemberImage(expResult);
        String result = v.getMemberImage();
        assertEquals(expResult, result);
    }

    /**
     * Test of getDescription method, of class Teammember.
     */
    @Test
    public void testGetDescription() {
        System.out.println("getDescription");
        String expResult = "Sample description for Teammember";
        String result = v.getDescription();
        assertEquals(expResult, result);
    }

    /**
     * Test of setDescription method, of class Teammember.
     */
    @Test
    public void testSetDescription() {
        System.out.println("setDescription");
        String expResult = "Sample description for Teammember";
        v.setDescription(expResult);
        String result = v.getDescription();
        assertEquals(expResult, result);
    }
}
