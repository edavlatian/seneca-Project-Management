<%-- 
    Document   : RegisterCompany
    Created on : Feb 20, 2012, 12:48:03 PM
    Author     : KepneR
--%>

<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%@page import="seneca.projectManagement.entity.*" %>
<%@page import="seneca.projectManagement.utils.*" %>
<%
    Company company = new Company();
    company.setCompanyName("");
    company.setCompanyPhone("");
    company.setCompanyDescription("");
    company.setBusinessAreas("");
    Accounts account = new Accounts();
    account.setAccountStatus(1);
    account.setPasswordHashed("");
    account.setUserEmail("");
    account.setUserFName("");
    account.setUserIdentifier("");
    account.setUserLName("");
    account.setUserRole("");

    if(session.getAttribute("agreed") == null) {
        session.setAttribute("AgreementError", "You have not agreed to the agreement form.");
        response.sendRedirect("AgreementForm.jsp");
    }
    
    if(session.getAttribute("Company") != null) {
        company = (Company) session.getAttribute("Company");
    }
    if(session.getAttribute("Account") != null) {
        account = (Accounts) session.getAttribute("Account");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="/PRJ666-Implementation/pages/resources/css/pageStuff.css" />
    <script type="text/javascript" src="/PRJ666-Implementation/pages/resources/js/twitter.js"></script>
    <title>PRJ566 - Home</title>
    <style type="text/css">
        input[type=text], textArea, input[type=password] {
            width: 300px;
        }
    </style>
  </head>
  <body>
    <table> 
      <tr>
        <td colspan="2">
          <table width="100%">
            <tr>
              <td width="402" style="background-image: url('/PRJ666-Implementation/pages/resources/images/header_left.jpg'); background-repeat: no-repeat;">&nbsp;</td>
              <td style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;" width="800">
                <a href="/PRJ666-Implementation/pages/Home.jsp" style="color: black;"><center><h2>WELCOME TO PRJ566<br/> Project Planning and Management</h2></center></a>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr valign="top">
        <td rowspan="5" align="left" width="200"> 
          <img src="/PRJ666-Implementation/pages/resources/images/seneca_logo.gif" title="Seneca logo"/>
          <br/>
          <img src="/PRJ666-Implementation/pages/resources/images/ICT_Logo.png" title="ICT Logo"/>
          <br/>
          <%
          if(userBean != null) {
            if(userBean.isLogged() == true) {
              Accounts temp_a = userBean.getLoggedUser();
              out.println("<hr width='95%' align='left'/>");
              Company temp_c = userBean.getCompany();
              out.print("Hello, Company " + temp_c.getCompanyName());
              out.println("<hr width='95%' align='left'/>");
            }
          }
          %>
          <div style="margin:2px; width:200px;">
            <script type="text/javascript"> 
		          new TWTR.Widget( {
  		          version: 2,
  		          type: "profile",
  		          rpp: 5,
 		            interval: 6000,
  		          width: "auto",
  		          height: 300,
  		          theme: {
    		          shell: {
      		          background: "#d5e7e9",
      		          color: "#000000"
    		          },
    		          tweets: {
      		          background: "#fffaff",
     		            color: "#000000",
      		          links: "#0772eb"
    		          }
  		          },	
  		          features: {
    		          scrollbar: false,
    		          loop: false,
    		          live: false,
    		          hashtags: true,
    		          timestamp: true,
    	    	      avatars: false,
    		          behavior: "all"
  		          }
		          } ).render().setUser( "Seneca_College" ).start();
		        </script>
		      </div>
        </td>
        <td style="background-image: url('/PRJ666-Implementation/pages/resources/images/header_bg.jpg')">
            <ul>
              <li><a href="/PRJ666-Implementation/pages/Home.jsp">Home</a></li>
              <li><a href="/PRJ666-Implementation/pages/login.jsp">Login</a></li>
              <li><a href="/PRJ666-Implementation/pages/archived.jsp">Archived Projects</a></li>
              <li><a href="/PRJ666-Implementation/pages/Company/AgreementForm.jsp">Company Registration</a></li>
            </ul>
        </td>
      </tr>
      <tr>
        <td>
            <h1>Company Registration Form</h1>
            <form method="POST" action="RegisterCompany.jsp">
                <div style="width: 700px; background-color: #D5E7E9; padding: 5px;">
                    Company Information 
                </div>
                <div style="width: 700px; padding: 5px">
                    <div style="float: left; width: 150px">Company Name:</div>
                    <div style="float: left"><input type="text" name="id_cname" value="<% out.println(company.getCompanyName()); %>"></div>
                    <div style="float: left; color: red">
                        <% 
                            if(session.getAttribute("cname") != null) {
                                out.println("* " + session.getAttribute("cname").toString());
                                session.removeAttribute("cname");
                            }
                        %>
                    </div>
                    <div style="clear: both"></div>
                    <div style="float: left; width: 150px">Business Areas:</div>
                    <div style="float: left"><textarea name="id_careas" cols="40" rows="5"><% out.println(company.getBusinessAreas()); %></textarea></div>
                    <div style="float: left; color: red">
                        <% 
                            if(session.getAttribute("careas") != null) {
                                out.println("* " + session.getAttribute("careas").toString());
                                session.removeAttribute("careas");
                            }
                        %>
                    </div>
                    <div style="clear: both"></div>
                    <div style="float: left; width: 150px">Company Description:</div>
                    <div style="float: left"><textarea name="id_cdesc" cols="40" rows="10"><% out.println(company.getCompanyDescription()); %></textarea></div>
                    <div style="float: left; color: red">
                        <% 
                            if(session.getAttribute("cdesc") != null) {
                                out.println("* " + session.getAttribute("cdesc").toString());
                                session.removeAttribute("cdesc");
                            }
                        %>
                    </div>
                    <div style="clear: both"></div>
                    <div style="float: left; width: 150px">Company Phone:</div>
                    <div style="float: left"><input type="text" name="id_cphone" value="<% out.println(company.getCompanyPhone()); %>"></div>
                    <div style="float: left; color: red">
                        <% 
                            if(session.getAttribute("cphone") != null) {
                                out.println("* " + session.getAttribute("cphone").toString());
                                session.removeAttribute("cphone");
                            }
                        %>
                    </div>
                    <div style="clear: both"></div>
                </div>
                <div style="width: 700px; background-color: #D5E7E9; padding: 5px;">
                    Account Information
                </div>
                <div style="width: 700px; padding: 5px">
                    <div style="float: left; width: 150px">First Name:</div>
                    <div style="float: left"><input type="text" name="id_fname" value="<% out.println(account.getUserFName()); %>"></div>
                    <div style="float: left; color: red">
                        <% 
                            if(session.getAttribute("fname") != null) {
                                out.println("* " + session.getAttribute("fname").toString());
                                session.removeAttribute("fname");
                            }
                        %>
                    </div>
                    <div style="clear: both"></div>
                    <div style="float: left; width: 150px">Last Name:</div>
                    <div style="float: left"><input type="text" name="id_lname" value="<% out.println(account.getUserLName()); %>"></div>
                    <div style="float: left; color: red">
                        <% 
                            if(session.getAttribute("lname") != null) {
                                out.println("* " + session.getAttribute("lname").toString());
                                session.removeAttribute("lname");
                            }
                        %>
                    </div>
                    <div style="clear: both"></div>
                    <div style="float: left; width: 150px">Email Address:</div>
                    <div style="float: left"><input type="text" name="id_email" value="<% out.println(account.getUserEmail()); %>"></div>
                    <div style="float: left; color: red">
                        <% 
                            if(session.getAttribute("email") != null) {
                                out.println("* " + session.getAttribute("email").toString());
                                session.removeAttribute("email");
                            }
                        %>
                    </div>
                    <div style="clear: both"><br/></div>
                    <div style="float: left; width: 150px">Username:</div>
                    <div style="float: left"><input type="text" name="id_user" value="<% out.println(account.getUserIdentifier()); %>"></div>
                    <div style="float: left; color: red">
                        <% 
                            if(session.getAttribute("user") != null) {
                                out.println("* " + session.getAttribute("user").toString());
                                session.removeAttribute("user");
                            }
                        %>
                    </div>
                    <div style="clear: both"></div>
                    <div style="float: left; width: 150px">Password:</div>
                    <div style="float: left"><input type="password" name="id_pass1" value=""></div>
                    <div style="float: left; color: red">
                        <% 
                            if(session.getAttribute("pass1") != null) {
                                out.println("* " + session.getAttribute("pass1").toString());
                                session.removeAttribute("pass1");
                            }
                        %>
                    </div>
                    <div style="clear: both"></div>
                    <div style="float: left; width: 150px">Again Password:</div>
                    <div style="float: left"><input type="password" name="id_pass2" value=""></div>
                    <div style="float: left; color: red">
                        <% 
                            if(session.getAttribute("pass2") != null) {
                                out.println("* " + session.getAttribute("pass2").toString());
                                session.removeAttribute("pass2");
                            }
                        %>
                    </div>
                    <div style="clear: both"></div>
                <div/>
                <div style="width: 700px; background-color: #D5E7E9; padding: 5px; text-align: right">
                    <input type="submit" value="Continue">
                </div>
            </form>
        </td>
      </tr>          
    </table>
  </body>
</html>
