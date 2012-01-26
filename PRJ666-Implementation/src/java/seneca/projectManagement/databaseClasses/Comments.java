/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.databaseClasses;

/**
 *
 * @author matthewschranz
 */
public class Comments {
  private int commentid;
  private int commentstatus;
  private String commentdescription;
  private int projectid;

  public Comments() {
  }

  public Comments(String commentdescription) {
    this.commentdescription = commentdescription;
  }

  public Integer getCommentid() {
    return commentid;
  }

  public void setCommentid(Integer commentid) {
    this.commentid = commentid;
  }

  public int getCommentstatus() {
    return commentstatus;
  }

  public void setCommentstatus(int commentstatus) {
    this.commentstatus = commentstatus;
  }

  public String getCommentdescription() {
    return commentdescription;
  }

  public void setCommentdescription(String commentdescription) {
    this.commentdescription = commentdescription;
  }

  public int getProjectid() {
    return projectid;
  }

  public void setProjectid(int projectid) {
    this.projectid = projectid;
  }
}
