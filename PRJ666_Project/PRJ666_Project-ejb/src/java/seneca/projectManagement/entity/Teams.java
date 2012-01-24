/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author matthewschranz
 */
@Entity
@Table(name = "TEAMS")
@NamedQueries({
  @NamedQuery(name = "Teams.findAll", query = "SELECT t FROM Teams t"),
  @NamedQuery(name = "Teams.findByTeamid", query = "SELECT t FROM Teams t WHERE t.teamid = :teamid"),
  @NamedQuery(name = "Teams.findByTeamidentifier", query = "SELECT t FROM Teams t WHERE t.teamidentifier = :teamidentifier"),
  @NamedQuery(name = "Teams.findByTeamemail", query = "SELECT t FROM Teams t WHERE t.teamemail = :teamemail"),
  @NamedQuery(name = "Teams.findByTeamstatus", query = "SELECT t FROM Teams t WHERE t.teamstatus = :teamstatus"),
  @NamedQuery(name = "Teams.findByTeamname", query = "SELECT t FROM Teams t WHERE t.teamname = :teamname"),
  @NamedQuery(name = "Teams.findByTeamconstraints", query = "SELECT t FROM Teams t WHERE t.teamconstraints = :teamconstraints"),
  @NamedQuery(name = "Teams.findByHasregistered", query = "SELECT t FROM Teams t WHERE t.hasregistered = :hasregistered")})
public class Teams implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Basic(optional = false)
  @NotNull
  @Column(name = "TEAMID")
  private Integer teamid;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 16)
  @Column(name = "TEAMIDENTIFIER")
  private String teamidentifier;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 200)
  @Column(name = "TEAMEMAIL")
  private String teamemail;
  @Column(name = "TEAMSTATUS")
  private Short teamstatus;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 20)
  @Column(name = "TEAMNAME")
  private String teamname;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 100)
  @Column(name = "TEAMCONSTRAINTS")
  private String teamconstraints;
  @Column(name = "HASREGISTERED")
  private Short hasregistered;
  @OneToMany(mappedBy = "teamid")
  private Collection<Teammember> teammemberCollection;
  @OneToMany(cascade = CascadeType.ALL, mappedBy = "teamid")
  private Collection<Teamprojectranking> teamprojectrankingCollection;
  @OneToMany(mappedBy = "teamid")
  private Collection<Projects> projectsCollection;
  @JoinColumn(name = "USERID", referencedColumnName = "USERID")
  @ManyToOne(optional = false)
  private Users userid;
  @JoinColumn(name = "PROJECTID", referencedColumnName = "PROJECTID")
  @ManyToOne
  private Projects projectid;

  public Teams() {
  }

  public Teams(Integer teamid) {
    this.teamid = teamid;
  }

  public Teams(Integer teamid, String teamidentifier, String teamemail, String teamname, String teamconstraints) {
    this.teamid = teamid;
    this.teamidentifier = teamidentifier;
    this.teamemail = teamemail;
    this.teamname = teamname;
    this.teamconstraints = teamconstraints;
  }

  public Integer getTeamid() {
    return teamid;
  }

  public void setTeamid(Integer teamid) {
    this.teamid = teamid;
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

  public Short getTeamstatus() {
    return teamstatus;
  }

  public void setTeamstatus(Short teamstatus) {
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

  public Short getHasregistered() {
    return hasregistered;
  }

  public void setHasregistered(Short hasregistered) {
    this.hasregistered = hasregistered;
  }

  public Collection<Teammember> getTeammemberCollection() {
    return teammemberCollection;
  }

  public void setTeammemberCollection(Collection<Teammember> teammemberCollection) {
    this.teammemberCollection = teammemberCollection;
  }

  public Collection<Teamprojectranking> getTeamprojectrankingCollection() {
    return teamprojectrankingCollection;
  }

  public void setTeamprojectrankingCollection(Collection<Teamprojectranking> teamprojectrankingCollection) {
    this.teamprojectrankingCollection = teamprojectrankingCollection;
  }

  public Collection<Projects> getProjectsCollection() {
    return projectsCollection;
  }

  public void setProjectsCollection(Collection<Projects> projectsCollection) {
    this.projectsCollection = projectsCollection;
  }

  public Users getUserid() {
    return userid;
  }

  public void setUserid(Users userid) {
    this.userid = userid;
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
    hash += (teamid != null ? teamid.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Teams)) {
      return false;
    }
    Teams other = (Teams) object;
    if ((this.teamid == null && other.teamid != null) || (this.teamid != null && !this.teamid.equals(other.teamid))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Teams[ teamid=" + teamid + " ]";
  }
  
}
