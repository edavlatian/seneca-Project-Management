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
@Table(name = "news")
@XmlRootElement
@NamedQueries({
  @NamedQuery(name = "News.findAll", query = "SELECT n FROM News n"),
  @NamedQuery(name = "News.findByPostId", query = "SELECT n FROM News n WHERE n.postId = :postId"),
  @NamedQuery(name = "News.findByPostDate", query = "SELECT n FROM News n WHERE n.postDate = :postDate"),
  @NamedQuery(name = "News.findByPostTitle", query = "SELECT n FROM News n WHERE n.postTitle = :postTitle"),
  @NamedQuery(name = "News.findByInstructorId", query = "SELECT n FROM News n WHERE n.instructorId = :instructorId")})
public class News implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @Column(name = "postId")
  private Integer postId;
  @Column(name = "postDate")
  @Temporal(TemporalType.TIMESTAMP)
  private Date postDate = new Date();
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 50)
  @Column(name = "postTitle")
  private String postTitle;
  @Basic(optional = false)
  @NotNull
  @Lob
  @Size(min = 1, max = 65535)
  @Column(name = "postText")
  private String postText;
  @Basic(optional = false)
  @NotNull
  @Column(name = "instructorId")
  private int instructorId;

  public News() {}

  public Integer getPostId() {
    return postId;
  }

  public void setPostId(Integer postId) {
    this.postId = postId;
  }

  public Date getPostDate() {
    return postDate;
  }

  public String getPostTitle() {
    return postTitle;
  }

  public void setPostTitle(String postTitle) {
    this.postTitle = postTitle;
  }

  public String getPostText() {
    return postText;
  }

  public void setPostText(String postText) {
    this.postText = postText;
  }

  public int getInstructorId() {
    return instructorId;
  }

  public void setInstructorId(int instructorId) {
    this.instructorId = instructorId;
  }

  @Override
  public int hashCode() {
    int hash = 0;
    hash += (postId != null ? postId.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof News)) {
      return false;
    }
    News other = (News) object;
    if ((this.postId == null && other.postId != null) || (this.postId != null && !this.postId.equals(other.postId))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.News[ postId=" + postId + " ]";
  }
  
}
