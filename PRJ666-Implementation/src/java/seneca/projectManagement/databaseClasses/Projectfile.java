/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.databaseClasses;

/**
 *
 * @author matthewschranz
 */
public class Projectfile {
  private int fileid;
  private String filename;
  private String filedescription;
  private String thefile;
  private int projectid;

  public Projectfile() {
  }

  public Projectfile(String filename, String filedescription, String thefile) {
    this.filename = filename;
    this.filedescription = filedescription;
    this.thefile = thefile;
  }

  public int getFileid() {
    return fileid;
  }

  public void setFileid(int fileid) {
    this.fileid = fileid;
  }

  public String getFilename() {
    return filename;
  }

  public void setFilename(String filename) {
    this.filename = filename;
  }

  public String getFiledescription() {
    return filedescription;
  }

  public void setFiledescription(String filedescription) {
    this.filedescription = filedescription;
  }

  public String getThefile() {
    return thefile;
  }

  public void setThefile(String thefile) {
    this.thefile = thefile;
  }

  public int getProjectid() {
    return projectid;
  }

  public void setProjectid(int projectid) {
    this.projectid = projectid;
  } 
}
