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
import seneca.projectManagement.utils.CryptoUtil;

/**
 *
 * @author matthewschranz
 */
@Entity
@Table(name = "accounts")
@XmlRootElement
@NamedQueries({
  @NamedQuery(name = "Accounts.findAll", query = "SELECT a FROM Accounts a"),
  @NamedQuery(name = "Accounts.findByUserId", query = "SELECT a FROM Accounts a WHERE a.userId = :userId"),
  @NamedQuery(name = "Accounts.findByUserIdentifier", query = "SELECT a FROM Accounts a WHERE a.userIdentifier = :userIdentifier"),
  @NamedQuery(name = "Accounts.findByUserFName", query = "SELECT a FROM Accounts a WHERE a.userFName = :userFName"),
  @NamedQuery(name = "Accounts.findByUserLName", query = "SELECT a FROM Accounts a WHERE a.userLName = :userLName"),
  @NamedQuery(name = "Accounts.findByUserEmail", query = "SELECT a FROM Accounts a WHERE a.userEmail = :userEmail"),
  @NamedQuery(name = "Accounts.findByUserRole", query = "SELECT a FROM Accounts a WHERE a.userRole = :userRole"),
  @NamedQuery(name = "Accounts.findByPassword", query = "SELECT a FROM Accounts a WHERE a.password = :password"),
  @NamedQuery(name = "Accounts.findByAccountStatus", query = "SELECT a FROM Accounts a WHERE a.accountStatus = :accountStatus")})
public class Accounts implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @Column(name = "userId")
  private Integer userId;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 25)
  @Column(name = "userIdentifier")
  private String userIdentifier;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 16)
  @Column(name = "userFName")
  private String userFName;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 16)
  @Column(name = "userLName")
  private String userLName;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 50)
  @Column(name = "userEmail")
  private String userEmail;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 2)
  @Column(name = "userRole")
  private String userRole;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 50)
  @Column(name = "password")
  private String password;
  @Column(name = "accountStatus")
  private Integer accountStatus = 1;

  public Accounts() {
  }

  public Integer getUserId() {
    return userId;
  }

  public void setUserId(Integer userId) {
    this.userId = userId;
  }

  public String getUserIdentifier() {
    return userIdentifier;
  }

  public void setUserIdentifier(String userIdentifier) {
    this.userIdentifier = userIdentifier;
  }

  public String getUserFName() {
    return userFName;
  }

  public void setUserFName(String userFName) {
    this.userFName = userFName;
  }

  public String getUserLName() {
    return userLName;
  }

  public void setUserLName(String userLName) {
    this.userLName = userLName;
  }

  public String getUserEmail() {
    return userEmail;
  }

  public void setUserEmail(String userEmail) {
    this.userEmail = userEmail;
  }

  public String getUserRole() {
    return userRole;
  }

  public void setUserRole(String userRole) {
    this.userRole = userRole;
  }

  public String getPassword() {
    return password;
  }

  public void setPasswordHashed(String password) {
    this.password = CryptoUtil.encodeBase64( CryptoUtil.digestSHA( password ) );
  }

  public Integer getAccountStatus() {
    return accountStatus;
  }

  public void setAccountStatus(Integer accountStatus) {
    this.accountStatus = accountStatus;
  }

  @Override
  public int hashCode() {
    int hash = 0;
    hash += (userId != null ? userId.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Accounts)) {
      return false;
    }
    Accounts other = (Accounts) object;
    if ((this.userId == null && other.userId != null) || (this.userId != null && !this.userId.equals(other.userId))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Accounts[ userId=" + userId + " ]";
  }
  
}
