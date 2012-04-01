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
@Table(name = "teams")
@XmlRootElement
@NamedQueries({
  @NamedQuery(name = "Teams.findAll", query = "SELECT t FROM Teams t"),
  @NamedQuery(name = "Teams.findByTeamId", query = "SELECT t FROM Teams t WHERE t.teamId = :teamId"),
  @NamedQuery(name = "Teams.findByTeamEmail", query = "SELECT t FROM Teams t WHERE t.teamEmail = :teamEmail"),
  @NamedQuery(name = "Teams.findByTeamStatus", query = "SELECT t FROM Teams t WHERE t.teamStatus = :teamStatus"),
  @NamedQuery(name = "Teams.findByTeamName", query = "SELECT t FROM Teams t WHERE t.teamName = :teamName"),
  @NamedQuery(name = "Teams.findByTeamConstraints", query = "SELECT t FROM Teams t WHERE t.teamConstraints = :teamConstraints"),
  @NamedQuery(name = "Teams.findByTeamDescription", query = "SELECT t FROM Teams t WHERE t.teamDescription = :teamDescription"),
  @NamedQuery(name = "Teams.findByTeamLogo", query = "SELECT t FROM Teams t WHERE t.teamLogo = :teamLogo"),
  @NamedQuery(name = "Teams.findByProjectId", query = "SELECT t FROM Teams t WHERE t.projectId = :projectId"),
  @NamedQuery(name = "Teams.findByHasRegistered", query = "SELECT t FROM Teams t WHERE t.hasRegistered = :hasRegistered"),
  @NamedQuery(name = "Teams.findByUserId", query = "SELECT t FROM Teams t WHERE t.userId = :userId")})
public class Teams implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @Column(name = "teamId")
  private Integer teamId;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 400)
  @Column(name = "teamEmail")
  private String teamEmail;
  @Column(name = "teamStatus")
  private Integer teamStatus = 1;
  @Size(max = 20)
  @Column(name = "teamName")
  private String teamName;
  @Lob
  @Size(max = 65535)
  @Column(name = "teamConstraints")
  private String teamConstraints;
  @Lob
  @Size(max = 65535)
  @Column(name = "teamDescription")
  private String teamDescription;
  @Lob
  @Size(max = 65535)
  @Column(name = "teamLogo")
  private String teamLogo;
  @Column(name = "projectId")
  private Integer projectId;
  @Column(name = "hasRegistered")
  private Integer hasRegistered = 0;
  @Basic(optional = false)
  @NotNull
  @Column(name = "userId")
  private int userId;

  public Teams() {
  }

  public Teams(Integer teamId) {
    this.teamId = teamId;
  }

  public Teams(Integer teamId, String teamEmail, int userId) {
    this.teamId = teamId;
    this.teamEmail = teamEmail;
    this.userId = userId;
  }

  public Integer getTeamId() {
    return teamId;
  }

  public String getTeamEmail() {
    return teamEmail;
  }

  public void setTeamEmail(String teamEmail) {
    this.teamEmail = teamEmail;
  }

  public Integer getTeamStatus() {
    return teamStatus;
  }

  public void setTeamStatus(Integer teamStatus) {
    this.teamStatus = teamStatus;
  }

  public String getTeamName() {
    return teamName;
  }

  public void setTeamName(String teamName) {
    this.teamName = teamName;
  }

  public String getTeamConstraints() {
    return teamConstraints;
  }

  public void setTeamConstraints(String teamConstraints) {
    this.teamConstraints = teamConstraints;
  }

  public String getTeamDescription() {
    return teamDescription;
  }

  public void setTeamDescription(String teamDescription) {
    this.teamDescription = teamDescription;
  }

  public String getTeamLogo() {
    return teamLogo;
  }

  public void setTeamLogo(String teamLogo) {
    this.teamLogo = teamLogo;
  }

  public Integer getProjectId() {
    return projectId;
  }

  public void setProjectId(Integer projectId) {
    this.projectId = projectId;
  }

  public Integer getHasRegistered() {
    return hasRegistered;
  }

  public void setHasRegistered(Integer hasRegistered) {
    this.hasRegistered = hasRegistered;
  }

  public int getUserId() {
    return userId;
  }

  public void setUserId(int userId) {
    this.userId = userId;
  }

  @Override
  public int hashCode() {
    int hash = 0;
    hash += (teamId != null ? teamId.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Teams)) {
      return false;
    }
    Teams other = (Teams) object;
    if ((this.teamId == null && other.teamId != null) || (this.teamId != null && !this.teamId.equals(other.teamId))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Teams[ teamId=" + teamId + " ]";
  }
  
}
