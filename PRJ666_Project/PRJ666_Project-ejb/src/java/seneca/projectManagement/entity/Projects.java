/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author matthewschranz
 */
@Entity
@Table(name = "PROJECTS")
@XmlRootElement
@NamedQueries({
  @NamedQuery(name = "Projects.findAll", query = "SELECT p FROM Projects p"),
  @NamedQuery(name = "Projects.findByProjectid", query = "SELECT p FROM Projects p WHERE p.projectid = :projectid"),
  @NamedQuery(name = "Projects.findByPrjidentifier", query = "SELECT p FROM Projects p WHERE p.prjidentifier = :prjidentifier"),
  @NamedQuery(name = "Projects.findByStatus", query = "SELECT p FROM Projects p WHERE p.status = :status"),
  @NamedQuery(name = "Projects.findByPrjname", query = "SELECT p FROM Projects p WHERE p.prjname = :prjname"),
  @NamedQuery(name = "Projects.findByDescription", query = "SELECT p FROM Projects p WHERE p.description = :description"),
  @NamedQuery(name = "Projects.findByPrjconstraints", query = "SELECT p FROM Projects p WHERE p.prjconstraints = :prjconstraints"),
  @NamedQuery(name = "Projects.findByAgreementdate", query = "SELECT p FROM Projects p WHERE p.agreementdate = :agreementdate")})
public class Projects implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Basic(optional = false)
  @NotNull
  @Column(name = "PROJECTID")
  private Integer projectid;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 13)
  @Column(name = "PRJIDENTIFIER")
  private String prjidentifier;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 2)
  @Column(name = "STATUS")
  private String status;
  @Size(max = 20)
  @Column(name = "PRJNAME")
  private String prjname;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 500)
  @Column(name = "DESCRIPTION")
  private String description;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 250)
  @Column(name = "PRJCONSTRAINTS")
  private String prjconstraints;
  @Basic(optional = false)
  @NotNull
  @Column(name = "AGREEMENTDATE")
  @Temporal(TemporalType.DATE)
  private Date agreementdate;
  @OneToMany(cascade = CascadeType.ALL, mappedBy = "projectid")
  private Collection<Projectfile> projectfileCollection;
  @OneToMany(cascade = CascadeType.ALL, mappedBy = "projectid")
  private Collection<Comments> commentsCollection;
  @OneToMany(cascade = CascadeType.ALL, mappedBy = "projects")
  private Collection<Teamprojectranking> teamprojectrankingCollection;
  @OneToMany(cascade = CascadeType.ALL, mappedBy = "projectid")
  private Collection<Milestone> milestoneCollection;
  @JoinColumn(name = "INSTRUCTORID", referencedColumnName = "USERID")
  @ManyToOne
  private Users instructorid;
  @JoinColumn(name = "TEAMID", referencedColumnName = "TEAMID")
  @ManyToOne
  private Teams teamid;
  @JoinColumn(name = "COMPANYID", referencedColumnName = "COMPANYID")
  @ManyToOne(optional = false)
  private Company companyid;
  @OneToMany(mappedBy = "projectid")
  private Collection<Teams> teamsCollection;

  public Projects() {
  }

  public Projects(Integer projectid) {
    this.projectid = projectid;
  }

  public Projects(Integer projectid, String prjidentifier, String status, String description, String prjconstraints, Date agreementdate) {
    this.projectid = projectid;
    this.prjidentifier = prjidentifier;
    this.status = status;
    this.description = description;
    this.prjconstraints = prjconstraints;
    this.agreementdate = agreementdate;
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

  public Date getAgreementdate() {
    return agreementdate;
  }

  public void setAgreementdate(Date agreementdate) {
    this.agreementdate = agreementdate;
  }

  @XmlTransient
  public Collection<Projectfile> getProjectfileCollection() {
    return projectfileCollection;
  }

  public void setProjectfileCollection(Collection<Projectfile> projectfileCollection) {
    this.projectfileCollection = projectfileCollection;
  }

  @XmlTransient
  public Collection<Comments> getCommentsCollection() {
    return commentsCollection;
  }

  public void setCommentsCollection(Collection<Comments> commentsCollection) {
    this.commentsCollection = commentsCollection;
  }

  @XmlTransient
  public Collection<Teamprojectranking> getTeamprojectrankingCollection() {
    return teamprojectrankingCollection;
  }

  public void setTeamprojectrankingCollection(Collection<Teamprojectranking> teamprojectrankingCollection) {
    this.teamprojectrankingCollection = teamprojectrankingCollection;
  }

  @XmlTransient
  public Collection<Milestone> getMilestoneCollection() {
    return milestoneCollection;
  }

  public void setMilestoneCollection(Collection<Milestone> milestoneCollection) {
    this.milestoneCollection = milestoneCollection;
  }

  public Users getInstructorid() {
    return instructorid;
  }

  public void setInstructorid(Users instructorid) {
    this.instructorid = instructorid;
  }

  public Teams getTeamid() {
    return teamid;
  }

  public void setTeamid(Teams teamid) {
    this.teamid = teamid;
  }

  public Company getCompanyid() {
    return companyid;
  }

  public void setCompanyid(Company companyid) {
    this.companyid = companyid;
  }

  @XmlTransient
  public Collection<Teams> getTeamsCollection() {
    return teamsCollection;
  }

  public void setTeamsCollection(Collection<Teams> teamsCollection) {
    this.teamsCollection = teamsCollection;
  }

  @Override
  public int hashCode() {
    int hash = 0;
    hash += (projectid != null ? projectid.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Projects)) {
      return false;
    }
    Projects other = (Projects) object;
    if ((this.projectid == null && other.projectid != null) || (this.projectid != null && !this.projectid.equals(other.projectid))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Projects[ projectid=" + projectid + " ]";
  }
  
}
