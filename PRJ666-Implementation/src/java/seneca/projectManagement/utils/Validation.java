/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.utils;

import seneca.projectManagement.entity.*;
import seneca.projectManagement.persistence.PersistenceController;
/**
 *
 * @author KepneR
 */
public class Validation {
    public static boolean isValidEmail(String email) {
        return email.matches("^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$");
    }
    
    public static boolean isValidPhone(String phone) {
        return phone.matches("\\d{3}[\\s-]*\\d{3}[\\s-]*\\d{4}");
    }
    
    public static boolean isValidPassSecure(String pass1, String pass2) {
        boolean value = false;
        if(pass1.equals(pass2) == true) {
            value = pass1.matches("(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{6,20}");
        }
        return value;
    }
    
    public static boolean isValidPassSimple(String pass1, String pass2) {
        boolean value = false;
        if(pass1.equals(pass2) == true) {
            value = pass1.matches("\\p{Alnum}+");
        }
        return value;
    }
    
    public static boolean isValidUsername(String username) {
        boolean value = true;
        
        try {
            PersistenceController pc = new PersistenceController();
            if(pc.getAccount(username) != null) {
                value = false;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        
        return value;
    }
    
    public static boolean isValidProject(String prjName) {
        boolean value = true;
        /*
        UserSession us = new UserSession();
        try {
            Projects proj = new Projects();
            proj.setPrjname(prjName);
            if(us.getProject(proj) != null) {
                value = false;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        */
        return value;
    }
}
