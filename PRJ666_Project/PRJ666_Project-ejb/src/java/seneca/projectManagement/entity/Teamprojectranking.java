/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author matthewschranz
 */
@Entity
@Table(name = "TEAMPROJECTRANKING", catalog = "", schema = "APP")
@XmlRootElement
@NamedQueries({
  @NamedQuery(name = "Teamprojectranking.findAll", query = "SELECT t FROM Teamprojectranking t"),
  @NamedQuery(name = "Teamprojectranking.findByTeamid", query = "SELECT t FROM Teamprojectranking t WHERE t.teamprojectrankingPK.teamid = :teamid"),
  @NamedQuery(name = "Teamprojectranking.findByProjectid", query = "SELECT t FROM Teamprojectranking t WHERE t.teamprojectrankingPK.projectid = :projectid"),
  @NamedQuery(name = "Teamprojectranking.findByWhoranked", query = "SELECT t FROM Teamprojectranking t WHERE t.teamprojectrankingPK.whoranked = :whoranked"),
  @NamedQuery(name = "Teamprojectranking.findByRanking", query = "SELECT t FROM Teamprojectranking t WHERE t.ranking = :ranking")})
public class Teamprojectranking implements Serializable {
  private static final long serialVersionUID = 1L;
  @EmbeddedId
  protected TeamprojectrankingPK teamprojectrankingPK;
  @Basic(optional = false)
  @NotNull
  @Column(name = "RANKING")
  private short ranking;
  @JoinColumn(name = "TEAMID", referencedColumnName = "TEAMID", insertable = false, updatable = false)
  @ManyToOne(optional = false)
  private Teams teams;
  @JoinColumn(name = "PROJECTID", referencedColumnName = "PROJECTID", insertable = false, updatable = false)
  @ManyToOne(optional = false)
  private Projects projects;

  public Teamprojectranking() {
  }

  public Teamprojectranking(TeamprojectrankingPK teamprojectrankingPK) {
    this.teamprojectrankingPK = teamprojectrankingPK;
  }

  public Teamprojectranking(TeamprojectrankingPK teamprojectrankingPK, short ranking) {
    this.teamprojectrankingPK = teamprojectrankingPK;
    this.ranking = ranking;
  }

  public Teamprojectranking(int teamid, int projectid, char whoranked) {
    this.teamprojectrankingPK = new TeamprojectrankingPK(teamid, projectid, whoranked);
  }

  public TeamprojectrankingPK getTeamprojectrankingPK() {
    return teamprojectrankingPK;
  }

  public void setTeamprojectrankingPK(TeamprojectrankingPK teamprojectrankingPK) {
    this.teamprojectrankingPK = teamprojectrankingPK;
  }

  public short getRanking() {
    return ranking;
  }

  public void setRanking(short ranking) {
    this.ranking = ranking;
  }

  public Teams getTeams() {
    return teams;
  }

  public void setTeams(Teams teams) {
    this.teams = teams;
  }

  public Projects getProjects() {
    return projects;
  }

  public void setProjects(Projects projects) {
    this.projects = projects;
  }

  @Override
  public int hashCode() {
    int hash = 0;
    hash += (teamprojectrankingPK != null ? teamprojectrankingPK.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Teamprojectranking)) {
      return false;
    }
    Teamprojectranking other = (Teamprojectranking) object;
    if ((this.teamprojectrankingPK == null && other.teamprojectrankingPK != null) || (this.teamprojectrankingPK != null && !this.teamprojectrankingPK.equals(other.teamprojectrankingPK))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Teamprojectranking[ teamprojectrankingPK=" + teamprojectrankingPK + " ]";
  }
  
}
