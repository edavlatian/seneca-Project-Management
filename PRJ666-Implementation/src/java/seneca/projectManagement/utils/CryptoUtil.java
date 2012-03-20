/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.utils;

/**
 *
 * @author matthewschranz
 */
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Date;
import java.util.Random;
import javax.xml.bind.DatatypeConverter;

public class CryptoUtil {
   private final static byte[] m_hashPrefix = "PRJ666_BEAMSOLUTIONS".getBytes();

   public static byte[] digestSHA(String... a) {
      try {
         MessageDigest md = MessageDigest.getInstance("SHA");

         md.update(m_hashPrefix);
         for (String s : a) {
            md.update(s.getBytes());
         }

         return md.digest();
      }
      catch (NoSuchAlgorithmException e) {
         return null;
      }
   }

   public static String encodeBase64(byte[] data) {
      return DatatypeConverter.printBase64Binary(data);
   }
   
   public static String generateRandomPassword() {
       Random ran = new Random(new Date().getTime());
       char[] lowChar = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'};
       char[] capChar = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
       char[] num = {'0','1','2','3','4','5','6','7','8','9'};
       StringBuilder ret = new StringBuilder(8);
       
       for(int i = 0; i < 2; i++) {
           ret.append(lowChar[ran.nextInt(lowChar.length)]);
       }
       for(int i = 0; i < 2; i++) {
           ret.append(capChar[ran.nextInt(capChar.length)]);
       }
       for(int i = 0; i < 4; i++) {
           ret.append(num[ran.nextInt(num.length)]);
       }
       
       return ret.toString();
   }
}