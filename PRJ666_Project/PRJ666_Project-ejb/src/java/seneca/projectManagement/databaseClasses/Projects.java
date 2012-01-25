/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.databaseClasses;

import java.sql.Timestamp;
import java.util.Collection;
import java.util.Date;

/**
 *
 * @author matthewschranz
 */
public class Projects {
  private Integer projectid;
  private String prjidentifier;
  private String status;
  private String prjname;
  private String description;
  private String prjconstraints;
  private Timestamp agreementdate;
  private int instructorid;
  private int teamid;
  private int companyid;

  public Projects() {
  }

  public Projects(String prjidentifier, String status, String description, String prjconstraints, Timestamp agreementdate) {
    this.prjidentifier = prjidentifier;
    this.status = status;
    this.description = description;
    this.prjconstraints = prjconstraints;
    this.agreementdate = agreementdate;
  }

  public Integer getProjectid() {
    return projectid;
  }

  public void setProjectid(Integer projectid) {
    this.projectid = projectid;
  }

  public String getPrjidentifier() {
    return prjidentifier;
  }

  public void setPrjidentifier(String prjidentifier) {
    this.prjidentifier = prjidentifier;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public String getPrjname() {
    return prjname;
  }

  public void setPrjname(String prjname) {
    this.prjname = prjname;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public String getPrjconstraints() {
    return prjconstraints;
  }

  public void setPrjconstraints(String prjconstraints) {
    this.prjconstraints = prjconstraints;
  }

  public Date getAgreementdate() {
    return agreementdate;
  }
}
