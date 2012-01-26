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
}