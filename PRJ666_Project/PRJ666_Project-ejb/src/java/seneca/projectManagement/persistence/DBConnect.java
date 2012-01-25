/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.persistence;

/**
 *
 * @author matthewschranz
 */
public final class DBConnect {
  
  private static String dbUrl = "jdbc:mysql://zenit.senecac.on.ca:3306/";
  private static String db = "prj666_121a06";
  private static String dbUser = "prj666_121a06";
  private static String dbPass = "bfGY3445";
  private static String driver = "com.mysql.jdbc.Driver";

  public static String getDriver() {
    return driver;
  }

  public static String getDb() {
    return db;
  }

  public static String getDbPass() {
    return dbPass;
  }

  public static String getDbUrl() {
    return dbUrl;
  }

  public static String getDbUser() {
    return dbUser;
  }
}
