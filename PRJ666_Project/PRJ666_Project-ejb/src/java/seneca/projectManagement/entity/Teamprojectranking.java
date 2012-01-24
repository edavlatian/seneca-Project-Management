/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

/**
 *
 * @author matthewschranz
 */
@Entity
@Table(name = "TEAMPROJECTRANKING")
@NamedQueries({
  @NamedQuery(name = "Teamprojectranking.findAll", query = "SELECT t FROM Teamprojectranking t"),
  @NamedQuery(name = "Teamprojectranking.findById", query = "SELECT t FROM Teamprojectranking t WHERE t.id = :id"),
  @NamedQuery(name = "Teamprojectranking.findByWhoranked", query = "SELECT t FROM Teamprojectranking t WHERE t.whoranked = :whoranked"),
  @NamedQuery(name = "Teamprojectranking.findByRanking", query = "SELECT t FROM Teamprojectranking t WHERE t.ranking = :ranking")})
public class Teamprojectranking implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Basic(optional = false)
  @NotNull
  @Column(name = "ID")
  private Integer id;
  @Basic(optional = false)
  @NotNull
  @Column(name = "WHORANKED")
  private char whoranked;
  @Basic(optional = false)
  @NotNull
  @Column(name = "RANKING")
  private short ranking;
  @JoinColumn(name = "TEAMID", referencedColumnName = "TEAMID")
  @ManyToOne(optional = false)
  private Teams teamid;
  @JoinColumn(name = "PROJECTID", referencedColumnName = "PROJECTID")
  @ManyToOne(optional = false)
  private Projects projectid;

  public Teamprojectranking() {
  }

  public Teamprojectranking(Integer id) {
    this.id = id;
  }

  public Teamprojectranking(Integer id, char whoranked, short ranking) {
    this.id = id;
    this.whoranked = whoranked;
    this.ranking = ranking;
  }

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public char getWhoranked() {
    return whoranked;
  }

  public void setWhoranked(char whoranked) {
    this.whoranked = whoranked;
  }

  public short getRanking() {
    return ranking;
  }

  public void setRanking(short ranking) {
    this.ranking = ranking;
  }

  public Teams getTeamid() {
    return teamid;
  }

  public void setTeamid(Teams teamid) {
    this.teamid = teamid;
  }

  public Projects getProjectid() {
    return projectid;
  }

  public void setProjectid(Projects projectid) {
    this.projectid = projectid;
  }

  @Override
  public int hashCode() {
    int hash = 0;
    hash += (id != null ? id.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Teamprojectranking)) {
      return false;
    }
    Teamprojectranking other = (Teamprojectranking) object;
    if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Teamprojectranking[ id=" + id + " ]";
  }
  
}
