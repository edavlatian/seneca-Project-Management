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
@Table(name = "COMPANY")
@NamedQueries({
  @NamedQuery(name = "Company.findAll", query = "SELECT c FROM Company c"),
  @NamedQuery(name = "Company.findByCompanyid", query = "SELECT c FROM Company c WHERE c.companyid = :companyid"),
  @NamedQuery(name = "Company.findByCompanyname", query = "SELECT c FROM Company c WHERE c.companyname = :companyname"),
  @NamedQuery(name = "Company.findByCompanyphone", query = "SELECT c FROM Company c WHERE c.companyphone = :companyphone"),
  @NamedQuery(name = "Company.findByProjectstatus", query = "SELECT c FROM Company c WHERE c.projectstatus = :projectstatus")})
public class Company implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Basic(optional = false)
  @NotNull
  @Column(name = "COMPANYID")
  private Integer companyid;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 25)
  @Column(name = "COMPANYNAME")
  private String companyname;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 12)
  @Column(name = "COMPANYPHONE")
  private String companyphone;
  @Column(name = "PROJECTSTATUS")
  private Short projectstatus;
  @JoinColumn(name = "REPID", referencedColumnName = "USERID")
  @ManyToOne(optional = false)
  private Users repid;
  @OneToMany(cascade = CascadeType.ALL, mappedBy = "companyid")
  private Collection<Projects> projectsCollection;

  public Company() {
  }

  public Company(Integer companyid) {
    this.companyid = companyid;
  }

  public Company(Integer companyid, String companyname, String companyphone) {
    this.companyid = companyid;
    this.companyname = companyname;
    this.companyphone = companyphone;
  }

  public Integer getCompanyid() {
    return companyid;
  }

  public void setCompanyid(Integer companyid) {
    this.companyid = companyid;
  }

  public String getCompanyname() {
    return companyname;
  }

  public void setCompanyname(String companyname) {
    this.companyname = companyname;
  }

  public String getCompanyphone() {
    return companyphone;
  }

  public void setCompanyphone(String companyphone) {
    this.companyphone = companyphone;
  }

  public Short getProjectstatus() {
    return projectstatus;
  }

  public void setProjectstatus(Short projectstatus) {
    this.projectstatus = projectstatus;
  }

  public Users getRepid() {
    return repid;
  }

  public void setRepid(Users repid) {
    this.repid = repid;
  }

  public Collection<Projects> getProjectsCollection() {
    return projectsCollection;
  }

  public void setProjectsCollection(Collection<Projects> projectsCollection) {
    this.projectsCollection = projectsCollection;
  }

  @Override
  public int hashCode() {
    int hash = 0;
    hash += (companyid != null ? companyid.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Company)) {
      return false;
    }
    Company other = (Company) object;
    if ((this.companyid == null && other.companyid != null) || (this.companyid != null && !this.companyid.equals(other.companyid))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Company[ companyid=" + companyid + " ]";
  }
  
}
