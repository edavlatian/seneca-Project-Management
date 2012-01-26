/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.databaseClasses;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

/**
 *
 * @author matthewschranz
 */
public class Milestone {
  private int milestoneid;
  private String description;
  private String milestonestatus;
  private Timestamp duedate;
  private int projectid;

  public Milestone(String description, String duedate) {
    this.description = description;
    setDuedate(duedate);
  }

  public Integer getMilestoneid() {
    return milestoneid;
  }

  public void setMilestoneid(Integer milestoneid) {
    this.milestoneid = milestoneid;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public String getMilestonestatus() {
    return milestonestatus;
  }

  public void setMilestonestatus(String milestonestatus) {
    this.milestonestatus = milestonestatus;
  }

  public Timestamp getDuedate() {
    return duedate;
  }

  public void setDuedate(String duedate) {
    DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
    try {
      this.duedate = new Timestamp(df.parse(duedate).getTime());  
    }
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  public int getProjectid() {
    return projectid;
  }

  public void setProjectid(int projectid) {
    this.projectid = projectid;
  }  
}
