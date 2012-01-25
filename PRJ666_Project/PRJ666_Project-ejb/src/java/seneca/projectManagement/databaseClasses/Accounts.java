/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.databaseClasses;

import seneca.projectManagement.utils.CryptoUtil;

/**
 *
 * @author matthewschranz
 */

public class Accounts {
  private int userid;
  private String userfname;
  private String userlname;
  private String useremail;
  private String useridentifier;
  private String userrole;
  private String password;
  private int accountstatus;

  public Accounts() {
  }

  public Accounts(String userfname, String userlname, String useremail, String useridentifier, String userrole, String password) {
    this.userfname = userfname;
    this.userlname = userlname;
    this.useremail = useremail;
    this.useridentifier = useridentifier;
    this.userrole = userrole;
    this.password = password;
  }

  public Integer getUserid() {
    return userid;
  }

  public String getUserfname() {
    return userfname;
  }

  public void setUserfname(String userfname) {
    this.userfname = userfname;
  }

  public String getUserlname() {
    return userlname;
  }

  public void setUserlname(String userlname) {
    this.userlname = userlname;
  }

  public String getUseremail() {
    return useremail;
  }

  public void setUseremail(String useremail) {
    this.useremail = useremail;
  }

  public String getUseridentifier() {
    return useridentifier;
  }

  public void setUseridentifier(String useridentifier) {
    this.useridentifier = useridentifier;
  }

  public String getUserrole() {
    return userrole;
  }

  public void setUserrole(String userrole) {
    this.userrole = userrole;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = CryptoUtil.encodeBase64(CryptoUtil.digestSHA(password));
  }

  public int getAccountstatus() {
    return accountstatus;
  }

  public void setAccountstatus(int accountstatus) {
    this.accountstatus = accountstatus;
  }
}
