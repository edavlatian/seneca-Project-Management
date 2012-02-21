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
public class Projects {
  private int projectid;
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

  public Projects(String prjName, String prjidentifier, String status, String description, String prjconstraints, String agreementdate) {
    this.prjname = prjName;
    this.prjidentifier = prjidentifier;
    this.status = status;
    this.description = description;
    this.prjconstraints = prjconstraints;
    
    DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
    try {
      this.agreementdate = new Timestamp(df.parse(agreementdate).getTime());
    }
    catch (Exception e){
      e.printStackTrace();
    }
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

  public Timestamp getAgreementdate() {
    return agreementdate;
  }
  
  public void setAgreementDate(String agreementdate) {
    DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
    try {
      this.agreementdate = new Timestamp(df.parse(agreementdate).getTime());
    }
    catch (Exception e){
      e.printStackTrace();
    }
  }

    public int getCompanyid() {
        return companyid;
    }

    public void setCompanyid(int companyid) {
        this.companyid = companyid;
    }

    public int getInstructorid() {
        return instructorid;
    }

    public void setInstructorid(int instructorid) {
        this.instructorid = instructorid;
    }

    public int getTeamid() {
        return teamid;
    }

    public void setTeamid(int teamid) {
        this.teamid = teamid;
    }
}
