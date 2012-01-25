/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.databaseClasses;

/**
 *
 * @author matthewschranz
 */

public class Teams {
  private int teamid;
  private String teamidentifier;
  private String teamemail;
  private int teamstatus;
  private String teamname;
  private String teamconstraints;
  private int hasregistered;
  private int userid;
  private int projectid;

  public Teams() {
  }

  public Teams(String teamidentifier, String teamemail, String teamname, String teamconstraints) {
    this.teamidentifier = teamidentifier;
    this.teamemail = teamemail;
    this.teamname = teamname;
    this.teamconstraints = teamconstraints;
  }

  public Integer getTeamid() {
    return teamid;
  }

  public String getTeamidentifier() {
    return teamidentifier;
  }

  public void setTeamidentifier(String teamidentifier) {
    this.teamidentifier = teamidentifier;
  }

  public String getTeamemail() {
    return teamemail;
  }

  public void setTeamemail(String teamemail) {
    this.teamemail = teamemail;
  }

  public int getTeamstatus() {
    return teamstatus;
  }

  public void setTeamstatus(int teamstatus) {
    this.teamstatus = teamstatus;
  }

  public String getTeamname() {
    return teamname;
  }

  public void setTeamname(String teamname) {
    this.teamname = teamname;
  }

  public String getTeamconstraints() {
    return teamconstraints;
  }

  public void setTeamconstraints(String teamconstraints) {
    this.teamconstraints = teamconstraints;
  }

  public int getHasregistered() {
    return hasregistered;
  }

  public void setHasregistered(int hasregistered) {
    this.hasregistered = hasregistered;
  }

  public int getUserid() {
    return userid;
  }
  
  public void setUserid(int aUserId) {
    this.userid = aUserId;
  }

  public int getProjectid() {
    return projectid;
  }
  
  public void setProjectid(int aProjectId) {
    this.projectid = aProjectId;
  }
}
