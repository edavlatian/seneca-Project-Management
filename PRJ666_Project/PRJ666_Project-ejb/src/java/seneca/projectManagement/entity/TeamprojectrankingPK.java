/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

/**
 *
 * @author matthewschranz
 */
@Embeddable
public class TeamprojectrankingPK implements Serializable {
  @Basic(optional = false)
  @NotNull
  @Column(name = "TEAMID")
  private int teamid;
  @Basic(optional = false)
  @NotNull
  @Column(name = "PROJECTID")
  private int projectid;
  @Basic(optional = false)
  @NotNull
  @Column(name = "WHORANKED")
  private char whoranked;

  public TeamprojectrankingPK() {
  }

  public TeamprojectrankingPK(int teamid, int projectid, char whoranked) {
    this.teamid = teamid;
    this.projectid = projectid;
    this.whoranked = whoranked;
  }

  public int getTeamid() {
    return teamid;
  }

  public void setTeamid(int teamid) {
    this.teamid = teamid;
  }

  public int getProjectid() {
    return projectid;
  }

  public void setProjectid(int projectid) {
    this.projectid = projectid;
  }

  public char getWhoranked() {
    return whoranked;
  }

  public void setWhoranked(char whoranked) {
    this.whoranked = whoranked;
  }

  @Override
  public int hashCode() {
    int hash = 0;
    hash += (int) teamid;
    hash += (int) projectid;
    hash += (int) whoranked;
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof TeamprojectrankingPK)) {
      return false;
    }
    TeamprojectrankingPK other = (TeamprojectrankingPK) object;
    if (this.teamid != other.teamid) {
      return false;
    }
    if (this.projectid != other.projectid) {
      return false;
    }
    if (this.whoranked != other.whoranked) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.TeamprojectrankingPK[ teamid=" + teamid + ", projectid=" + projectid + ", whoranked=" + whoranked + " ]";
  }
  
}
