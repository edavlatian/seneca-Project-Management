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
@Table(name = "teammember")
@XmlRootElement
@NamedQueries({
  @NamedQuery(name = "Teammember.findAll", query = "SELECT t FROM Teammember t"),
  @NamedQuery(name = "Teammember.findByMemberId", query = "SELECT t FROM Teammember t WHERE t.memberId = :memberId"),
  @NamedQuery(name = "Teammember.findByFirstName", query = "SELECT t FROM Teammember t WHERE t.firstName = :firstName"),
  @NamedQuery(name = "Teammember.findByLastName", query = "SELECT t FROM Teammember t WHERE t.lastName = :lastName"),
  @NamedQuery(name = "Teammember.findByEmail", query = "SELECT t FROM Teammember t WHERE t.email = :email"),
  @NamedQuery(name = "Teammember.findByMemberImage", query = "SELECT t FROM Teammember t WHERE t.memberImage = :memberImage"),
  @NamedQuery(name = "Teammember.findByDescription", query = "SELECT t FROM Teammember t WHERE t.description = :description"),
  @NamedQuery(name = "Teammember.findByTeamLeader", query = "SELECT t FROM Teammember t WHERE t.teamLeader = :teamLeader"),
  @NamedQuery(name = "Teammember.findByTeamId", query = "SELECT t FROM Teammember t WHERE t.teamId = :teamId")})
public class Teammember implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @Column(name = "memberId")
  private Integer memberId;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 15)
  @Column(name = "firstName")
  private String firstName;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 15)
  @Column(name = "lastName")
  private String lastName;
  // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 50)
  @Column(name = "email")
  private String email;
  @Lob
  @Size(max = 65535)
  @Column(name = "memberImage")
  private String memberImage;
  @Lob
  @Size(max = 65535)
  @Column(name = "description")
  private String description;
  @Column(name = "teamLeader")
  private Integer teamLeader = 0;
  @Basic(optional = false)
  @NotNull
  @Column(name = "teamId")
  private int teamId;

  public Teammember() {
  }

  public Integer getMemberId() {
    return memberId;
  }

  public void setMemberId(Integer memberId) {
    this.memberId = memberId;
  }

  public String getFirstName() {
    return firstName;
  }

  public void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  public String getLastName() {
    return lastName;
  }

  public void setLastName(String lastName) {
    this.lastName = lastName;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getMemberImage() {
    return memberImage;
  }

  public void setMemberImage(String memberImage) {
    this.memberImage = memberImage;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public Integer getTeamLeader() {
    return teamLeader;
  }

  public void setTeamLeader(Integer teamLeader) {
    this.teamLeader = teamLeader;
  }

  public int getTeamId() {
    return teamId;
  }

  public void setTeamId(int teamId) {
    this.teamId = teamId;
  }

  @Override
  public int hashCode() {
    int hash = 0;
    hash += (memberId != null ? memberId.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Teammember)) {
      return false;
    }
    Teammember other = (Teammember) object;
    if ((this.memberId == null && other.memberId != null) || (this.memberId != null && !this.memberId.equals(other.memberId))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Teammember[ memberId=" + memberId + " ]";
  }
  
}
