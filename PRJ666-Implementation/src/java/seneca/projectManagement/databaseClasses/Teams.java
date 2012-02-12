/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.databaseClasses;

import java.sql.Blob;

/**
 *
 * @author matthewschranz
 */

public class Teams {
  private int teamid;
  private String teamemail;
  private int teamstatus;
  private String teamname;
  private String teamconstraints;
  private String teamDescription;
  private Blob teamLogo;
  private int hasregistered;
  private int userid;
  private int projectid;

  public Teams() {
  }

  public Teams(int aUserId, String aTeamEmail, String aTeamName, String aTeamConstraints) {
    this.userid = aUserId;
    this.teamemail = aTeamEmail;
    this.teamname = aTeamName;
    this.teamconstraints = aTeamConstraints;
  }

  public Blob getTeamLogo() {
    return teamLogo;
  }

  public void setTeamLogo(Blob teamLogo) {
    this.teamLogo = teamLogo;
  }

  public int getTeamid() {
    return teamid;
  }

  public String getTeamDescription() {
    return teamDescription;
  }

  public void setTeamDescription(String teamDescription) {
    this.teamDescription = teamDescription;
  }

  public void setTeamid(int teamid) {
    this.teamid = teamid;
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
