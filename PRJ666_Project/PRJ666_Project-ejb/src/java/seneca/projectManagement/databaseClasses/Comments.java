/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.databaseClasses;

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
@Table(name = "COMMENTS")
@NamedQueries({
  @NamedQuery(name = "Comments.findAll", query = "SELECT c FROM Comments c"),
  @NamedQuery(name = "Comments.findByCommentid", query = "SELECT c FROM Comments c WHERE c.commentid = :commentid"),
  @NamedQuery(name = "Comments.findByCommentstatus", query = "SELECT c FROM Comments c WHERE c.commentstatus = :commentstatus"),
  @NamedQuery(name = "Comments.findByCommentdescription", query = "SELECT c FROM Comments c WHERE c.commentdescription = :commentdescription")})
public class Comments implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Basic(optional = false)
  @NotNull
  @Column(name = "COMMENTID")
  private Integer commentid;
  @Column(name = "COMMENTSTATUS")
  private Short commentstatus;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 500)
  @Column(name = "COMMENTDESCRIPTION")
  private String commentdescription;
  @JoinColumn(name = "PROJECTID", referencedColumnName = "PROJECTID")
  @ManyToOne(optional = false)
  private Projects projectid;

  public Comments() {
  }

  public Comments(Integer commentid) {
    this.commentid = commentid;
  }

  public Comments(Integer commentid, String commentdescription) {
    this.commentid = commentid;
    this.commentdescription = commentdescription;
  }

  public Integer getCommentid() {
    return commentid;
  }

  public void setCommentid(Integer commentid) {
    this.commentid = commentid;
  }

  public Short getCommentstatus() {
    return commentstatus;
  }

  public void setCommentstatus(Short commentstatus) {
    this.commentstatus = commentstatus;
  }

  public String getCommentdescription() {
    return commentdescription;
  }

  public void setCommentdescription(String commentdescription) {
    this.commentdescription = commentdescription;
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
    hash += (commentid != null ? commentid.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Comments)) {
      return false;
    }
    Comments other = (Comments) object;
    if ((this.commentid == null && other.commentid != null) || (this.commentid != null && !this.commentid.equals(other.commentid))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Comments[ commentid=" + commentid + " ]";
  }
  
}
