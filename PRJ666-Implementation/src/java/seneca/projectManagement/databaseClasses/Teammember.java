/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.databaseClasses;

/**
 *
 * @author matthewschranz
 */
public class Teammember {
  private int memberid;
  private String firstname;
  private String lastname;
  private String email;
  private String image;
  private String description;
  private int teamleader;
  private int teamid;

  public Teammember() {
    firstname = lastname = email = image = description = "";
  }

  public Teammember(String aFirstname, String aLastname, String aEmail, int aTeamId) {
    this.firstname = aFirstname;
    this.lastname = aLastname;
    this.email = aEmail;
    this.teamid = aTeamId;
    this.image = description =  "";
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

  public String getImage() {
    return image;
  }

  public void setImage(String image) {
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
