/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.databaseClasses;

import java.io.Serializable;

/**
 *
 * @author matthewschranz
 */
public class Teammember {
  private int memberid;
  private String firstname;
  private String lastname;
  private String email;
  private Serializable image;
  private String description;
  private int teamleader;
  private int teamid;

  public Teammember() {
  }

  public Teammember(String firstname, String lastname, String email) {
    this.firstname = firstname;
    this.lastname = lastname;
    this.email = email;
  }

  public Integer getMemberid() {
    return memberid;
  }

  public void setMemberid(Integer memberid) {
    this.memberid = memberid;
  }

  public String getFirstname() {
    return firstname;
  }

  public void setFirstname(String firstname) {
    this.firstname = firstname;
  }

  public String getLastname() {
    return lastname;
  }

  public void setLastname(String lastname) {
    this.lastname = lastname;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public Serializable getImage() {
    return image;
  }

  public void setImage(Serializable image) {
    this.image = image;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public int getTeamleader() {
    return teamleader;
  }

  public void setTeamleader(int teamleader) {
    this.teamleader = teamleader;
  }

  public int getTeamid() {
    return teamid;
  }

  public void setTeamid(int teamid) {
    this.teamid = teamid;
  }
}
