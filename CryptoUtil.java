import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.xml.bind.DatatypeConverter;

// Example of how we will be hashing passwords to give an extra level of security
// Before anytime you are 

public class CryptoUtil {
   private final static byte[] m_hashPrefix = "PRJ666_BEAMSOLUTIONS".getBytes();

   public static void hashPassForDB(String a) {
     try {
         MessageDigest md = MessageDigest.getInstance("SHA");

         md.update(a.getBytes());
         byte byteData[] = md.digest();
         
         //convert the byte to hex format method 1
         StringBuffer sb = new StringBuffer();
         for (int i = 0; i < byteData.length; i++) {
           sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
         }

         // Insert logic to insert to DB
     }
     catch (Exception e){}
   }
   
   public static void hashPass(String a) {
     try {
         MessageDigest md = MessageDigest.getInstance("SHA");

         md.update(a.getBytes());
         byte byteData[] = md.digest();
         
         //convert the byte to hex format method 1
         StringBuffer sb = new StringBuffer();
         for (int i = 0; i < byteData.length; i++) {
           sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
         }
         
         // Would be replaced with a return of the password in string format for comparison to what is pulled from the DATABASE
         System.out.println(sb.toString());
     }
     catch (Exception e){}
   }

   public static String encodeBase64(byte[] data) {
      return DatatypeConverter.printBase64Binary(data);
   }
   
   public static void main(String args[]) {
     System.out.println("Password 12345:");
     hashPass("12345");
     System.out.println("Password 1a2s3d4f!%2f2f:");
     hashPass("1a2s3d4f!%2f2f");
     System.out.println("Password 1a2s3d4f!%2f2f23123123123n123un123un123un123ubn123i1m2ei123%%%%:");
     hashPass("1a2s3d4f!%2f2f23123123123n123un123un123un123ubn123i1m2ei123%%%%");
   }
}