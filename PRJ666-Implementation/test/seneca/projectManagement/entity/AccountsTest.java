/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import org.junit.After;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotSame;
import org.junit.Before;
import org.junit.Test;

/**
 *
 * @author KepneR
 */
public class AccountsTest {
    private Accounts valid;
    
    @Before
    public void setUp() {        
        // TL Valid
        valid = new Accounts();
        valid.setAccountStatus(1);
        valid.setPasswordHashed("12345");
        valid.setUserEmail("klcaliso1@learn.senecac.on.ca");
        valid.setUserFName("Kepner");
        valid.setUserLName("Caliso");
        valid.setUserIdentifier("kepner.caliso");
        valid.setUserRole("TL");
    }

    @After
    public void tearDown() {
        valid = null;
    }

    /**
     * Test of getUserIdentifier method, of class Accounts.
     */
    @Test
    public void testGetUserIdentifier() {
        System.out.println("getUserIdentifier");
        
        String expResult = "kepner.caliso";
        String result = valid.getUserIdentifier();
        assertEquals(expResult, result);
    }
    
    /**
     * Test of setUserIdentifier method, of class Accounts.
     */
    @Test
    public void testSetUserIdentifier() {
        System.out.println("setUserIdentifier");
        String expResult = "caliso.kepner";
        valid.setUserIdentifier(expResult);
        String result = valid.getUserIdentifier();
        assertEquals(expResult, result);
    }

    /**
     * Test of getUserFName method, of class Accounts.
     */
    @Test
    public void testGetUserFName() {
        System.out.println("getUserFName");
        String expResult = "Kepner";
        String result = valid.getUserFName();
        assertEquals(expResult, result);
    }

    /**
     * Test of setUserFName method, of class Accounts.
     */
    @Test
    public void testSetUserFName() {
        System.out.println("setUserFName");
        String expResult = "Caliso";
        valid.setUserFName(expResult);
        String result = valid.getUserFName();
        assertEquals(expResult, result);
    }

    /**
     * Test of getUserLName method, of class Accounts.
     */
    @Test
    public void testGetUserLName() {
        System.out.println("getUserLName");
        String expResult = "Caliso";
        String result = valid.getUserLName();
        assertEquals(expResult, result);
    }

    /**
     * Test of setUserLName method, of class Accounts.
     */
    @Test
    public void testSetUserLName() {
        System.out.println("setUserLName");
        String expResult = "Kepner";
        valid.setUserLName(expResult);
        String result = valid.getUserLName();
        assertEquals(expResult, result);
    }

    /**
     * Test of getUserEmail method, of class Accounts.
     */
    @Test
    public void testGetUserEmail() {
        System.out.println("getUserEmail");
        String expResult = "klcaliso1@learn.senecac.on.ca";
        String result = valid.getUserEmail();
        assertEquals(expResult, result);
    }

    /**
     * Test of setUserEmail method, of class Accounts.
     */
    @Test
    public void testSetUserEmail() {
        System.out.println("setUserEmail");
        String expResult = "kepner.caliso@senecac.on.ca";
        valid.setUserEmail(expResult);
        String result = valid.getUserEmail();
        assertEquals(expResult, result);
    }

    /**
     * Test of getUserRole method, of class Accounts.
     */
    @Test
    public void testGetUserRole() {
        System.out.println("getUserRole");
        String expResult = "TL";
        String result = valid.getUserRole();
        assertEquals(expResult, result);
    }

    /**
     * Test of setUserRole method, of class Accounts.
     */
    @Test
    public void testSetUserRole() {
        System.out.println("setUserRole");
        String expResult = "SU";
        valid.setUserRole(expResult);
        String result = valid.getUserRole();
        assertEquals(expResult, result);
    }

    /**
     * Test of getPassword method, of class Accounts.
     */
    @Test
    public void testGetPassword() {
        System.out.println("getPassword");
        String expResult = "12345";
        String result = valid.getPassword();
        assertNotSame(expResult, result);
    }

    /**
     * Test of setPasswordHashed method, of class Accounts.
     */
    @Test
    public void testSetPasswordHashed() {
        System.out.println("setPasswordHashed");
        String expResult = "12345";
        valid.setPasswordHashed(expResult);
        String result = valid.getPassword();
        assertNotSame(expResult, result);
    }

    /**
     * Test of getAccountStatus method, of class Accounts.
     */
    @Test
    public void testGetAccountStatus() {
        System.out.println("getAccountStatus");
        Integer expResult = 1;
        Integer result = valid.getAccountStatus();
        assertEquals(expResult, result);
    }

    /**
     * Test of setAccountStatus method, of class Accounts.
     */
    @Test
    public void testSetAccountStatus() {
        System.out.println("setAccountStatus");
        Integer expResult = 0;
        valid.setAccountStatus(expResult);
        Integer result = valid.getAccountStatus();
        assertEquals(expResult, result);
    }    
}
