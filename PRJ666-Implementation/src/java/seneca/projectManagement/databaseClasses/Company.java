/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.databaseClasses;

/**
 *
 * @author matthewschranz
 */
public class Company {
  private int companyid;
  private String companyname;
  private String companyphone;
  private int projectstatus;
  private int repid;

  public Company() {
  }
  
  public Company(String companyname, String companyphone) {
    this.companyid = companyid;
    this.companyname = companyname;
    this.companyphone = companyphone;
  }

  public Integer getCompanyid() {
    return companyid;
  }

  public void setCompanyid(Integer companyid) {
    this.companyid = companyid;
  }

  public String getCompanyname() {
    return companyname;
  }

  public void setCompanyname(String companyname) {
    this.companyname = companyname;
  }

  public String getCompanyphone() {
    return companyphone;
  }

  public void setCompanyphone(String companyphone) {
    this.companyphone = companyphone;
  }

  public int getProjectstatus() {
    return projectstatus;
  }

  public void setProjectstatus(Short projectstatus) {
    this.projectstatus = projectstatus;
  }

  public int getRepid() {
    return repid;
  }

  public void setRepid(int repid) {
    this.repid = repid;
  }  
}
