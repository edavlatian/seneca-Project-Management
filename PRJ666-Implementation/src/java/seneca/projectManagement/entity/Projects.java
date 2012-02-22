/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author matthewschranz
 */
@Entity
@Table(name = "projects")
@XmlRootElement
@NamedQueries({
  @NamedQuery(name = "Projects.findAll", query = "SELECT p FROM Projects p"),
  @NamedQuery(name = "Projects.findByProjectId", query = "SELECT p FROM Projects p WHERE p.projectId = :projectId"),
  @NamedQuery(name = "Projects.findByStatus", query = "SELECT p FROM Projects p WHERE p.status = :status"),
  @NamedQuery(name = "Projects.findByPrjName", query = "SELECT p FROM Projects p WHERE p.prjName = :prjName"),
  @NamedQuery(name = "Projects.findByDescription", query = "SELECT p FROM Projects p WHERE p.description = :description"),
  @NamedQuery(name = "Projects.findByPrjConstraints", query = "SELECT p FROM Projects p WHERE p.prjConstraints = :prjConstraints"),
  @NamedQuery(name = "Projects.findByAgreementDate", query = "SELECT p FROM Projects p WHERE p.agreementDate = :agreementDate"),
  @NamedQuery(name = "Projects.findByCompanyId", query = "SELECT p FROM Projects p WHERE p.companyId = :companyId"),
  @NamedQuery(name = "Projects.findByTeamId", query = "SELECT p FROM Projects p WHERE p.teamId = :teamId"),
  @NamedQuery(name = "Projects.findByInstructorId", query = "SELECT p FROM Projects p WHERE p.instructorId = :instructorId")})
public class Projects implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @Column(name = "projectId")
  private Integer projectId;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 2)
  @Column(name = "status")
  private String status;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 20)
  @Column(name = "prjName")
  private String prjName;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 500)
  @Column(name = "description")
  private String description;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 250)
  @Column(name = "prjConstraints")
  private String prjConstraints;
  @Column(name = "agreementDate")
  @Temporal(TemporalType.TIMESTAMP)
  private Date agreementDate = new Date();
  @Basic(optional = false)
  @NotNull
  @Column(name = "companyId")
  private int companyId;
  @Column(name = "teamId")
  private Integer teamId;
  @Column(name = "instructorId")
  private Integer instructorId;

  public Projects() {
  }

  public Integer getProjectId() {
    return projectId;
  }

  public void setProjectId(Integer projectId) {
    this.projectId = projectId;
  }

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public String getPrjName() {
    return prjName;
  }

  public void setPrjName(String prjName) {
    this.prjName = prjName;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public String getPrjConstraints() {
    return prjConstraints;
  }

  public void setPrjConstraints(String prjConstraints) {
    this.prjConstraints = prjConstraints;
  }

  public Date getAgreementDate() {
    return agreementDate;
  }

  public void setAgreementDate(Date agreementDate) {
    this.agreementDate = agreementDate;
  }

  public int getCompanyId() {
    return companyId;
  }

  public void setCompanyId(int companyId) {
    this.companyId = companyId;
  }

  public Integer getTeamId() {
    return teamId;
  }

  public void setTeamId(Integer teamId) {
    this.teamId = teamId;
  }

  public Integer getInstructorId() {
    return instructorId;
  }

  public void setInstructorId(Integer instructorId) {
    this.instructorId = instructorId;
  }

  @Override
  public int hashCode() {
    int hash = 0;
    hash += (projectId != null ? projectId.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Projects)) {
      return false;
    }
    Projects other = (Projects) object;
    if ((this.projectId == null && other.projectId != null) || (this.projectId != null && !this.projectId.equals(other.projectId))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Projects[ projectId=" + projectId + " ]";
  }
  
}
