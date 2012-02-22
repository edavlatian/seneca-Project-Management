/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import java.io.Serializable;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author matthewschranz
 */
@Entity
@Table(name = "teamprojectranking")
@XmlRootElement
@NamedQueries({
  @NamedQuery(name = "Teamprojectranking.findAll", query = "SELECT t FROM Teamprojectranking t"),
  @NamedQuery(name = "Teamprojectranking.findByRankId", query = "SELECT t FROM Teamprojectranking t WHERE t.rankId = :rankId"),
  @NamedQuery(name = "Teamprojectranking.findByTeamId", query = "SELECT t FROM Teamprojectranking t WHERE t.teamId = :teamId"),
  @NamedQuery(name = "Teamprojectranking.findByProjectId", query = "SELECT t FROM Teamprojectranking t WHERE t.projectId = :projectId"),
  @NamedQuery(name = "Teamprojectranking.findByWhoRanked", query = "SELECT t FROM Teamprojectranking t WHERE t.whoRanked = :whoRanked"),
  @NamedQuery(name = "Teamprojectranking.findByRanking", query = "SELECT t FROM Teamprojectranking t WHERE t.ranking = :ranking"),
  @NamedQuery(name = "Teamprojectranking.findByWhenRanked", query = "SELECT t FROM Teamprojectranking t WHERE t.whenRanked = :whenRanked")})
public class Teamprojectranking implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @Column(name = "rankId")
  private Integer rankId;
  @Basic(optional = false)
  @NotNull
  @Column(name = "teamId")
  private int teamId;
  @Basic(optional = false)
  @NotNull
  @Column(name = "projectId")
  private int projectId;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 1)
  @Column(name = "whoRanked")
  private String whoRanked;
  @Basic(optional = false)
  @NotNull
  @Column(name = "ranking")
  private int ranking;
  @Size(max = 3)
  @Column(name = "whenRanked")
  private String whenRanked;

  public Teamprojectranking() {
  }

  public Integer getRankId() {
    return rankId;
  }

  public void setRankId(Integer rankId) {
    this.rankId = rankId;
  }

  public int getTeamId() {
    return teamId;
  }

  public void setTeamId(int teamId) {
    this.teamId = teamId;
  }

  public int getProjectId() {
    return projectId;
  }

  public void setProjectId(int projectId) {
    this.projectId = projectId;
  }

  public String getWhoRanked() {
    return whoRanked;
  }

  public void setWhoRanked(String whoRanked) {
    this.whoRanked = whoRanked;
  }

  public int getRanking() {
    return ranking;
  }

  public void setRanking(int ranking) {
    this.ranking = ranking;
  }

  public String getWhenRanked() {
    return whenRanked;
  }

  public void setWhenRanked(String whenRanked) {
    this.whenRanked = whenRanked;
  }

  @Override
  public int hashCode() {
    int hash = 0;
    hash += (rankId != null ? rankId.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Teamprojectranking)) {
      return false;
    }
    Teamprojectranking other = (Teamprojectranking) object;
    if ((this.rankId == null && other.rankId != null) || (this.rankId != null && !this.rankId.equals(other.rankId))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Teamprojectranking[ rankId=" + rankId + " ]";
  }
  
}
