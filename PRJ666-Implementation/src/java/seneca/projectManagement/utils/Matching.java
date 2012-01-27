/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.utils;

/**
 *
 * @author matthewschranz
 */
public class Matching {
  private int teamId;
  private int projectId;
  private String whoRanked;
  private int ranking;

  public Matching(int teamId, int projectId, String whoRanked, int ranking) {
    this.teamId = teamId;
    this.projectId = projectId;
    this.whoRanked = whoRanked;
    this.ranking = ranking;
  }

  public int getProjectId() {
    return projectId;
  }

  public void setProjectId(int projectId) {
    this.projectId = projectId;
  }

  public int getRanking() {
    return ranking;
  }

  public void setRanking(int ranking) {
    this.ranking = ranking;
  }

  public int getTeamId() {
    return teamId;
  }

  public void setTeamId(int teamId) {
    this.teamId = teamId;
  }

  public String getWhoRanked() {
    return whoRanked;
  }

  public void setWhoRanked(String whoRanked) {
    this.whoRanked = whoRanked;
  }
  
  
}
