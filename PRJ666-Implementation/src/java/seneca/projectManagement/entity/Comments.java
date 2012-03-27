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
@Table(name = "comments")
@XmlRootElement
@NamedQueries({
  @NamedQuery(name = "Comments.findAll", query = "SELECT c FROM Comments c"),
  @NamedQuery(name = "Comments.findByCommentId", query = "SELECT c FROM Comments c WHERE c.commentId = :commentId"),
  @NamedQuery(name = "Comments.findByCommentStatus", query = "SELECT c FROM Comments c WHERE c.commentStatus = :commentStatus"),
  @NamedQuery(name = "Comments.findByCommentDescription", query = "SELECT c FROM Comments c WHERE c.commentDescription = :commentDescription"),
  @NamedQuery(name = "Comments.findByProjectId", query = "SELECT c FROM Comments c WHERE c.projectId = :projectId")})
public class Comments implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @Column(name = "commentId")
  private Integer commentId;
  @Column(name = "commentStatus")
  private Integer commentStatus = 0;
  @Basic(optional = false)
  @NotNull
  @Lob
  @Size(min = 1, max = 65535)
  @Column(name = "commentDescription")
  private String commentDescription;
  @Basic(optional = false)
  @NotNull
  @Column(name = "projectId")
  private int projectId;

  public Comments() {
  }

  public Integer getCommentId() {
    return commentId;
  }

  public void setCommentId(Integer commentId) {
    this.commentId = commentId;
  }

  public Integer getCommentStatus() {
    return commentStatus;
  }

  public void setCommentStatus(Integer commentStatus) {
    this.commentStatus = commentStatus;
  }

  public String getCommentDescription() {
    return commentDescription;
  }

  public void setCommentDescription(String commentDescription) {
    this.commentDescription = commentDescription;
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
    hash += (commentId != null ? commentId.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Comments)) {
      return false;
    }
    Comments other = (Comments) object;
    if ((this.commentId == null && other.commentId != null) || (this.commentId != null && !this.commentId.equals(other.commentId))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Comments[ commentId=" + commentId + " ]";
  }
  
}
