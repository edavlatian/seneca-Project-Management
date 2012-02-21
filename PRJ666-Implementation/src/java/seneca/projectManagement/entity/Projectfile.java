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
@Table(name = "projectfile")
@XmlRootElement
@NamedQueries({
  @NamedQuery(name = "Projectfile.findAll", query = "SELECT p FROM Projectfile p"),
  @NamedQuery(name = "Projectfile.findByFileId", query = "SELECT p FROM Projectfile p WHERE p.fileId = :fileId"),
  @NamedQuery(name = "Projectfile.findByFileName", query = "SELECT p FROM Projectfile p WHERE p.fileName = :fileName"),
  @NamedQuery(name = "Projectfile.findByFileDescription", query = "SELECT p FROM Projectfile p WHERE p.fileDescription = :fileDescription"),
  @NamedQuery(name = "Projectfile.findByTheFile", query = "SELECT p FROM Projectfile p WHERE p.theFile = :theFile"),
  @NamedQuery(name = "Projectfile.findByProjectId", query = "SELECT p FROM Projectfile p WHERE p.projectId = :projectId")})
public class Projectfile implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Basic(optional = false)
  @NotNull
  @Column(name = "fileId")
  private Integer fileId;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 40)
  @Column(name = "fileName")
  private String fileName;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 120)
  @Column(name = "fileDescription")
  private String fileDescription;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 500)
  @Column(name = "theFile")
  private String theFile;
  @Basic(optional = false)
  @NotNull
  @Column(name = "projectId")
  private int projectId;

  public Projectfile() {
  }

  public Integer getFileId() {
    return fileId;
  }

  public void setFileId(Integer fileId) {
    this.fileId = fileId;
  }

  public String getFileName() {
    return fileName;
  }

  public void setFileName(String fileName) {
    this.fileName = fileName;
  }

  public String getFileDescription() {
    return fileDescription;
  }

  public void setFileDescription(String fileDescription) {
    this.fileDescription = fileDescription;
  }

  public String getTheFile() {
    return theFile;
  }

  public void setTheFile(String theFile) {
    this.theFile = theFile;
  }

  public int getProjectId() {
    return projectId;
  }

  public void setProjectId(int projectId) {
    this.projectId = projectId;
  }

  @Override
  public int hashCode() {
    int hash = 0;
    hash += (fileId != null ? fileId.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Projectfile)) {
      return false;
    }
    Projectfile other = (Projectfile) object;
    if ((this.fileId == null && other.fileId != null) || (this.fileId != null && !this.fileId.equals(other.fileId))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Projectfile[ fileId=" + fileId + " ]";
  }
  
}
