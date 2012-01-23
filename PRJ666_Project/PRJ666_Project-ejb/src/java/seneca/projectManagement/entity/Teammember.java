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
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author matthewschranz
 */
@Entity
@Table(name = "TEAMMEMBER")
@XmlRootElement
@NamedQueries({
  @NamedQuery(name = "Teammember.findAll", query = "SELECT t FROM Teammember t"),
  @NamedQuery(name = "Teammember.findByMemberid", query = "SELECT t FROM Teammember t WHERE t.memberid = :memberid"),
  @NamedQuery(name = "Teammember.findByFirstname", query = "SELECT t FROM Teammember t WHERE t.firstname = :firstname"),
  @NamedQuery(name = "Teammember.findByLastname", query = "SELECT t FROM Teammember t WHERE t.lastname = :lastname"),
  @NamedQuery(name = "Teammember.findByEmail", query = "SELECT t FROM Teammember t WHERE t.email = :email"),
  @NamedQuery(name = "Teammember.findByDescription", query = "SELECT t FROM Teammember t WHERE t.description = :description"),
  @NamedQuery(name = "Teammember.findByTeamleader", query = "SELECT t FROM Teammember t WHERE t.teamleader = :teamleader")})
public class Teammember implements Serializable {
  private static final long serialVersionUID = 1L;
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Basic(optional = false)
  @NotNull
  @Column(name = "MEMBERID")
  private Integer memberid;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 15)
  @Column(name = "FIRSTNAME")
  private String firstname;
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 15)
  @Column(name = "LASTNAME")
  private String lastname;
  // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
  @Basic(optional = false)
  @NotNull
  @Size(min = 1, max = 50)
  @Column(name = "EMAIL")
  private String email;
  @Lob
  @Column(name = "IMAGE")
  private Serializable image;
  @Size(max = 250)
  @Column(name = "DESCRIPTION")
  private String description;
  @Column(name = "TEAMLEADER")
  private Short teamleader;
  @JoinColumn(name = "TEAMID", referencedColumnName = "TEAMID")
  @ManyToOne
  private Teams teamid;

  public Teammember() {
  }

  public Teammember(Integer memberid) {
    this.memberid = memberid;
  }

  public Teammember(Integer memberid, String firstname, String lastname, String email) {
    this.memberid = memberid;
    this.firstname = firstname;
    this.lastname = lastname;
    this.email = email;
  }

  public Integer getMemberid() {
    return memberid;
  }

  public void setMemberid(Integer memberid) {
    this.memberid = memberid;
  }

  public String getFirstname() {
    return firstname;
  }

  public void setFirstname(String firstname) {
    this.firstname = firstname;
  }

  public String getLastname() {
    return lastname;
  }

  public void setLastname(String lastname) {
    this.lastname = lastname;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public Serializable getImage() {
    return image;
  }

  public void setImage(Serializable image) {
    this.image = image;
  }

  public String getDescription() {
    return description;
  }

  public void setDescription(String description) {
    this.description = description;
  }

  public Short getTeamleader() {
    return teamleader;
  }

  public void setTeamleader(Short teamleader) {
    this.teamleader = teamleader;
  }

  public Teams getTeamid() {
    return teamid;
  }

  public void setTeamid(Teams teamid) {
    this.teamid = teamid;
  }

  @Override
  public int hashCode() {
    int hash = 0;
    hash += (memberid != null ? memberid.hashCode() : 0);
    return hash;
  }

  @Override
  public boolean equals(Object object) {
    // TODO: Warning - this method won't work in the case the id fields are not set
    if (!(object instanceof Teammember)) {
      return false;
    }
    Teammember other = (Teammember) object;
    if ((this.memberid == null && other.memberid != null) || (this.memberid != null && !this.memberid.equals(other.memberid))) {
      return false;
    }
    return true;
  }

  @Override
  public String toString() {
    return "seneca.projectManagement.entity.Teammember[ memberid=" + memberid + " ]";
  }
  
}
