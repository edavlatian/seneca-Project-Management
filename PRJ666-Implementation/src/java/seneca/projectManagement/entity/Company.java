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
@Table(name = "company")
@XmlRootElement
@NamedQueries({
  @NamedQuery(name = "Company.findAll", query = "SELECT c FROM Company c"),
  @NamedQuery(name = "Company.findByCompanyId", query = "SELECT c FROM Company c WHERE c.companyId = :companyId"),
  @NamedQuery(name = "Company.findByCompanyName", query = "SELECT c FROM Company c WHERE c.companyName = :companyName"),
  @NamedQuery(name = "Company.findByCompanyPhone", query = "SELECT c FROM Company c WHERE c.companyPhone = :companyPhone"),
  @NamedQuery(name = "Company.findByBusinessAreas", query = "SELECT c FROM Company c WHERE c.businessAreas = :businessAreas"),
  @NamedQuery(name = "Company.findByCompanyDescription", query = "SELECT c FROM Company c WHERE c.companyDescription = :companyDescription"),
  @NamedQuery(name = "Company.findByUserId", query = "SELECT c FROM Company c WHERE c.userId = :userId")})
public class Company implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @Column(name = "companyId")
  private Integer companyId;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 25)
  @Column(name = "companyName")
  private String companyName;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 12)
  @Column(name = "companyPhone")
  private String companyPhone;
  @Lob
  @Size(max = 65535)
  @Column(name = "businessAreas")
  private String businessAreas;
  @Lob
  @Size(max = 65535)
  @Column(name = "companyDescription")
  private String companyDescription;
  @Basic(optional = false)
  @NotNull
  @Column(name = "userId")
  private int userId;

  public Company() {
  }

  public Integer getCompanyId() {
    return companyId;
  }

  public void setCompanyId(Integer companyId) {
    this.companyId = companyId;
  }

  public String getCompanyName() {
    return companyName;
  }

  public void setCompanyName(String companyName) {
    this.companyName = companyName;
  }

  public String getCompanyPhone() {
    return companyPhone;
  }

  public void setCompanyPhone(String companyPhone) {
    this.companyPhone = companyPhone;
  }

  public String getBusinessAreas() {
    return businessAreas;
  }

  public void setBusinessAreas(String businessAreas) {
    this.businessAreas = businessAreas;
  }

  public String getCompanyDescription() {
    return companyDescription;
  }

  public void setCompanyDescription(String companyDescription) {
    this.companyDescription = companyDescription;
  }

  public int getUserId() {
    return userId;
  }

  public void setUserId(int userId) {
    this.userId = userId;
  }

  @Override
  public int hashCode() {
    int hash = 0;
    hash += (companyId != null ? companyId.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Company)) {
      return false;
    }
    Company other = (Company) object;
    if ((this.companyId == null && other.companyId != null) || (this.companyId != null && !this.companyId.equals(other.companyId))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Company[ companyId=" + companyId + " ]";
  }
  
}
