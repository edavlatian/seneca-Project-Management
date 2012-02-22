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
@Table(name = "milestone")
@XmlRootElement
@NamedQueries({
  @NamedQuery(name = "Milestone.findAll", query = "SELECT m FROM Milestone m"),
  @NamedQuery(name = "Milestone.findByMilestoneId", query = "SELECT m FROM Milestone m WHERE m.milestoneId = :milestoneId"),
  @NamedQuery(name = "Milestone.findByDescription", query = "SELECT m FROM Milestone m WHERE m.description = :description"),
  @NamedQuery(name = "Milestone.findByProjectId", query = "SELECT m FROM Milestone m WHERE m.projectId = :projectId"),
  @NamedQuery(name = "Milestone.findByMilestoneStatus", query = "SELECT m FROM Milestone m WHERE m.milestoneStatus = :milestoneStatus"),
  @NamedQuery(name = "Milestone.findByDueDate", query = "SELECT m FROM Milestone m WHERE m.dueDate = :dueDate")})
public class Milestone implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @Column(name = "milestoneId")
  private Integer milestoneId;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 125)
  @Column(name = "description")
  private String description;
  @Basic(optional = false)
  @NotNull
  @Column(name = "projectId")
  private int projectId;
  @Size(max = 2)
  @Column(name = "milestoneStatus")
  private String milestoneStatus = "NS";
  @Column(name = "dueDate")
  @Temporal(TemporalType.TIMESTAMP)
  private Date dueDate = new Date();

  public Milestone() {
  }

  public Integer getMilestoneId() {
    return milestoneId;
  }

  public void setMilestoneId(Integer milestoneId) {
    this.milestoneId = milestoneId;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public int getProjectId() {
    return projectId;
  }

  public void setProjectId(int projectId) {
    this.projectId = projectId;
  }

  public String getMilestoneStatus() {
    return milestoneStatus;
  }

  public void setMilestoneStatus(String milestoneStatus) {
    this.milestoneStatus = milestoneStatus;
  }

  public Date getDueDate() {
    return dueDate;
  }

  public void setDueDate(Date dueDate) {
    this.dueDate = dueDate;
  }

  @Override
  public int hashCode() {
    int hash = 0;
    hash += (milestoneId != null ? milestoneId.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Milestone)) {
      return false;
    }
    Milestone other = (Milestone) object;
    if ((this.milestoneId == null && other.milestoneId != null) || (this.milestoneId != null && !this.milestoneId.equals(other.milestoneId))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Milestone[ milestoneId=" + milestoneId + " ]";
  }
  
}
