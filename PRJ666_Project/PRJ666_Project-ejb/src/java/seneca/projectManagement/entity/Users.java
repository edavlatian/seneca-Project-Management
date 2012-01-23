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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;
import seneca.projectManagement.utils.CryptoUtil;

/**
 *
 * @author matthewschranz
 */
@Entity
@Table(name = "USERS", catalog = "", schema = "APP")
@XmlRootElement
@NamedQueries({
  @NamedQuery(name = "Users.findAll", query = "SELECT u FROM Users u"),
  @NamedQuery(name = "Users.findByUserid", query = "SELECT u FROM Users u WHERE u.userid = :userid"),
  @NamedQuery(name = "Users.findByUserfname", query = "SELECT u FROM Users u WHERE u.userfname = :userfname"),
  @NamedQuery(name = "Users.findByUserlname", query = "SELECT u FROM Users u WHERE u.userlname = :userlname"),
  @NamedQuery(name = "Users.findByUseremail", query = "SELECT u FROM Users u WHERE u.useremail = :useremail"),
  @NamedQuery(name = "Users.findByUseridentifier", query = "SELECT u FROM Users u WHERE u.useridentifier = :useridentifier"),
  @NamedQuery(name = "Users.findByUserrole", query = "SELECT u FROM Users u WHERE u.userrole = :userrole"),
  @NamedQuery(name = "Users.findByPassword", query = "SELECT u FROM Users u WHERE u.password = :password"),
  @NamedQuery(name = "Users.findByAccountstatus", query = "SELECT u FROM Users u WHERE u.accountstatus = :accountstatus")})
public class Users implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Basic(optional = false)
  @NotNull
  @Column(name = "USERID")
  private Integer userid;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 16)
  @Column(name = "USERFNAME")
  private String userfname;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 16)
  @Column(name = "USERLNAME")
  private String userlname;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 50)
  @Column(name = "USEREMAIL")
  private String useremail;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 25)
  @Column(name = "USERIDENTIFIER")
  private String useridentifier;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 2)
  @Column(name = "USERROLE")
  private String userrole;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 50)
  @Column(name = "PASSWORD")
  private String password;
  @Column(name = "ACCOUNTSTATUS")
  private Short accountstatus;
  @OneToMany(cascade = CascadeType.ALL, mappedBy = "repid")
  private Collection<Company> companyCollection;
  @OneToMany(mappedBy = "instructorid")
  private Collection<Projects> projectsCollection;
  @OneToMany(cascade = CascadeType.ALL, mappedBy = "userid")
  private Collection<Teams> teamsCollection;

  public Users() {
  }

  public Users(String userfname, String userlname, String useremail, String useridentifier, String userrole, String passphrase) {
    this.userfname = userfname;
    this.userlname = userlname;
    this.useremail = useremail;
    this.useridentifier = useridentifier;
    this.userrole = userrole;
    this.password = CryptoUtil.encodeBase64(CryptoUtil.digestSHA(passphrase));
  }

  public Integer getUserid() {
    return userid;
  }

  public void setUserid(Integer userid) {
    this.userid = userid;
  }

  public String getUserfname() {
    return userfname;
  }

  public void setUserfname(String userfname) {
    this.userfname = userfname;
  }

  public String getUserlname() {
    return userlname;
  }

  public void setUserlname(String userlname) {
    this.userlname = userlname;
  }

  public String getUseremail() {
    return useremail;
  }

  public void setUseremail(String useremail) {
    this.useremail = useremail;
  }

  public String getUseridentifier() {
    return useridentifier;
  }

  public void setUseridentifier(String useridentifier) {
    this.useridentifier = useridentifier;
  }

  public String getUserrole() {
    return userrole;
  }

  public void setUserrole(String userrole) {
    this.userrole = userrole;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
  }

  public Short getAccountstatus() {
    return accountstatus;
  }

  public void setAccountstatus(Short accountstatus) {
    this.accountstatus = accountstatus;
  }

  @XmlTransient
  public Collection<Company> getCompanyCollection() {
    return companyCollection;
  }

  public void setCompanyCollection(Collection<Company> companyCollection) {
    this.companyCollection = companyCollection;
  }

  @XmlTransient
  public Collection<Projects> getProjectsCollection() {
    return projectsCollection;
  }

  public void setProjectsCollection(Collection<Projects> projectsCollection) {
    this.projectsCollection = projectsCollection;
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
    hash += (userid != null ? userid.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Users)) {
      return false;
    }
    Users other = (Users) object;
    if ((this.userid == null && other.userid != null) || (this.userid != null && !this.userid.equals(other.userid))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Users[ userid=" + userid + " ]";
  }
  
}
