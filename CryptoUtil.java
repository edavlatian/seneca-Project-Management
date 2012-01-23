import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.xml.bind.DatatypeConverter;

// Example of how we will be hashing passwords to give an extra level of security
// Before anytime you are 

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
   
   public static void main(String args[]) {
     System.out.println("Password 12345:");
     System.out.println(encodeBase64(digestSHA("12345")));
     System.out.println("Password 1a2s3d4f!%2f2f:");
     System.out.println(encodeBase64(digestSHA("1a2s3d4f!%2f2f")));
     System.out.println("Password 1a2s3d4f!%2f2f23123123123n123un123un123un123ubn123i1m2ei123%%%%:");
     System.out.println(encodeBase64(digestSHA("1a2s3d4f!%2f2f23123123123n123un123un123un123ubn123i1m2ei123%%%%")));
   }
}