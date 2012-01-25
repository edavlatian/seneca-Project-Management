/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.databaseClasses;

/**
 *
 * @author matthewschranz
 */
public class Teamprojectranking {
  private int id;
  private String whoranked;
  private int ranking;
  private int teamid;
  private int projectid;

  public Teamprojectranking() {
  }

  public Teamprojectranking(String whoranked, int ranking) {
    this.whoranked = whoranked;
    this.ranking = ranking;
  }

  public int getId() {
    return id;
  }

  public String getWhoranked() {
    return whoranked;
  }

  public void setWhoranked(String whoranked) {
    this.whoranked = whoranked;
  }

  public int getRanking() {
    return ranking;
  }

  public void setRanking(short ranking) {
    this.ranking = ranking;
  }

  public int getTeamid() {
    return teamid;
  }

  public void setTeamid(int teamid) {
    this.teamid = teamid;
  }

  public int getProjectid() {
    return projectid;
  }

  public void setProjectid(int projectid) {
    this.projectid = projectid;
  }
}
