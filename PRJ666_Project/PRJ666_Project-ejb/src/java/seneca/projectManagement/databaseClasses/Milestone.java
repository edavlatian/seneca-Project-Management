/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.databaseClasses;

import java.io.Serializable;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author matthewschranz
 */
@Entity
@Table(name = "MILESTONE")
@NamedQueries({
  @NamedQuery(name = "Milestone.findAll", query = "SELECT m FROM Milestone m"),
  @NamedQuery(name = "Milestone.findByMilestoneid", query = "SELECT m FROM Milestone m WHERE m.milestoneid = :milestoneid"),
  @NamedQuery(name = "Milestone.findByDescription", query = "SELECT m FROM Milestone m WHERE m.description = :description"),
  @NamedQuery(name = "Milestone.findByMilestonestatus", query = "SELECT m FROM Milestone m WHERE m.milestonestatus = :milestonestatus"),
  @NamedQuery(name = "Milestone.findByDuedate", query = "SELECT m FROM Milestone m WHERE m.duedate = :duedate")})
public class Milestone implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Basic(optional = false)
  @NotNull
  @Column(name = "MILESTONEID")
  private Integer milestoneid;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 125)
  @Column(name = "DESCRIPTION")
  private String description;
  @Size(max = 2)
  @Column(name = "MILESTONESTATUS")
  private String milestonestatus;
  @Basic(optional = false)
  @NotNull
  @Column(name = "DUEDATE")
  @Temporal(TemporalType.DATE)
  private Date duedate;
  @JoinColumn(name = "PROJECTID", referencedColumnName = "PROJECTID")
  @ManyToOne(optional = false)
  private Projects projectid;

  public Milestone() {
  }

  public Milestone(Integer milestoneid) {
    this.milestoneid = milestoneid;
  }

  public Milestone(Integer milestoneid, String description, Date duedate) {
    this.milestoneid = milestoneid;
    this.description = description;
    this.duedate = duedate;
  }

  public Integer getMilestoneid() {
    return milestoneid;
  }

  public void setMilestoneid(Integer milestoneid) {
    this.milestoneid = milestoneid;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public String getMilestonestatus() {
    return milestonestatus;
  }

  public void setMilestonestatus(String milestonestatus) {
    this.milestonestatus = milestonestatus;
  }

  public Date getDuedate() {
    return duedate;
  }

  public void setDuedate(Date duedate) {
    this.duedate = duedate;
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
    hash += (milestoneid != null ? milestoneid.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Milestone)) {
      return false;
    }
    Milestone other = (Milestone) object;
    if ((this.milestoneid == null && other.milestoneid != null) || (this.milestoneid != null && !this.milestoneid.equals(other.milestoneid))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Milestone[ milestoneid=" + milestoneid + " ]";
  }
  
}
