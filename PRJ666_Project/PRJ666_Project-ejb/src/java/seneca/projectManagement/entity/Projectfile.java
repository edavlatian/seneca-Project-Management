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
import javax.validation.constraints.Size;

/**
 *
 * @author matthewschranz
 */
@Entity
@Table(name = "PROJECTFILE")
@NamedQueries({
  @NamedQuery(name = "Projectfile.findAll", query = "SELECT p FROM Projectfile p"),
  @NamedQuery(name = "Projectfile.findByFileid", query = "SELECT p FROM Projectfile p WHERE p.fileid = :fileid"),
  @NamedQuery(name = "Projectfile.findByFilename", query = "SELECT p FROM Projectfile p WHERE p.filename = :filename"),
  @NamedQuery(name = "Projectfile.findByFiledescription", query = "SELECT p FROM Projectfile p WHERE p.filedescription = :filedescription"),
  @NamedQuery(name = "Projectfile.findByThefile", query = "SELECT p FROM Projectfile p WHERE p.thefile = :thefile")})
public class Projectfile implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Basic(optional = false)
  @NotNull
  @Column(name = "FILEID")
  private Integer fileid;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 16)
  @Column(name = "FILENAME")
  private String filename;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 120)
  @Column(name = "FILEDESCRIPTION")
  private String filedescription;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 500)
  @Column(name = "THEFILE")
  private String thefile;
  @JoinColumn(name = "PROJECTID", referencedColumnName = "PROJECTID")
  @ManyToOne(optional = false)
  private Projects projectid;

  public Projectfile() {
  }

  public Projectfile(Integer fileid) {
    this.fileid = fileid;
  }

  public Projectfile(Integer fileid, String filename, String filedescription, String thefile) {
    this.fileid = fileid;
    this.filename = filename;
    this.filedescription = filedescription;
    this.thefile = thefile;
  }

  public Integer getFileid() {
    return fileid;
  }

  public void setFileid(Integer fileid) {
    this.fileid = fileid;
  }

  public String getFilename() {
    return filename;
  }

  public void setFilename(String filename) {
    this.filename = filename;
  }

  public String getFiledescription() {
    return filedescription;
  }

  public void setFiledescription(String filedescription) {
    this.filedescription = filedescription;
  }

  public String getThefile() {
    return thefile;
  }

  public void setThefile(String thefile) {
    this.thefile = thefile;
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
    hash += (fileid != null ? fileid.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Projectfile)) {
      return false;
    }
    Projectfile other = (Projectfile) object;
    if ((this.fileid == null && other.fileid != null) || (this.fileid != null && !this.fileid.equals(other.fileid))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Projectfile[ fileid=" + fileid + " ]";
  }
  
}
