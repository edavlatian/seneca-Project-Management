/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.utils;

import seneca.projectManagement.entity.UserSession;
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
        UserSession us = new UserSession();
        try {
            if(us.getAccounts(username) != null) {
                value = false;
            } else {
                value = username.matches("[\\p{Alnum}.]+");
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return value;
    }
}
