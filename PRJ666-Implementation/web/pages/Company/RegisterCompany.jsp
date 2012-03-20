<%-- 
    Document   : RegisterCompany
    Created on : Feb 20, 2012, 2:03:43 PM
    Author     : KepneR
--%>

<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%@page import="seneca.projectManagement.utils.*" %>
<%@page import="seneca.projectManagement.entity.*" %>
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
    boolean errorFound = false;
    
    if(session.getAttribute("agreed") == null && userBean != null) {
        session.setAttribute("AgreementError", "You have not agreed to the agreement form.");
        response.sendRedirect("AgreementForm.jsp");
    } else {
        String cname = request.getParameter("id_cname");
        if(cname == null) {
            session.setAttribute("cname", "Cannot be empty!");
            errorFound = true;
        } else if(cname.isEmpty() == true) {
            session.setAttribute("cname", "Cannot be empty!");
            errorFound = true;
        } else if(cname.length() > 25) {
            session.setAttribute("cname", "Cannot be longer than 25 characters!");
            errorFound = true;
        } else {
            company.setCompanyName(cname);
        }
        
        String careas = request.getParameter("id_careas");
        if(careas == null) {
            session.setAttribute("careas", "Cannot be empty!");
            errorFound = true;
        } else if(careas.isEmpty() == true) {
            session.setAttribute("careas", "Cannot be empty!");
            errorFound = true;
        } else if(careas.length() > 200) {
            session.setAttribute("careas", "Cannot be longer than 200 characters!");
            errorFound = true;
        } else {
            company.setBusinessAreas(careas);
        }
        
        String cdesc = request.getParameter("id_cdesc");
        if(cdesc == null) {
            session.setAttribute("cdesc", "Cannot be empty!");
            errorFound = true;
        } else if(cdesc.isEmpty() == true) {
            session.setAttribute("cdesc", "Cannot be empty!");
            errorFound = true;
        } else if(cdesc.length() > 600) {
            session.setAttribute("cdesc", "Cannot be longer than 600 characters!");
            errorFound = true;
        } else {
            company.setCompanyDescription(cdesc);
        }

        String cphone = request.getParameter("id_cphone");
        if(cphone == null) {
            session.setAttribute("cphone", "Cannot be empty!");
            errorFound = true;
        } else if(cphone.isEmpty() == true) {
            session.setAttribute("cphone", "Cannot be empty!");
            errorFound = true;
        } else {
            if(Validation.isValidPhone(cphone) == true) {
                company.setCompanyPhone(cphone);
            } else {
                session.setAttribute("cphone", "Invalid phone number!");
                errorFound = true;
            }
        }

        String fname = request.getParameter("id_fname");
        if(fname == null) {
            session.setAttribute("fname", "Cannot be empty!");
            errorFound = true;
        } else if(fname.isEmpty() == true) {
            session.setAttribute("fname", "Cannot be empty!");
            errorFound = true;
        } else {
            account.setUserFName(fname);
        }

        String lname = request.getParameter("id_lname");
        if(lname == null) {
            session.setAttribute("lname", "Cannot be empty!");
            errorFound = true;
        } else if(lname.isEmpty() == true) {
            session.setAttribute("lname", "Cannot be empty!");
            errorFound = true;
        } else {
            account.setUserLName(lname);
        }

        String user = request.getParameter("id_user");
        if(user == null) {
            session.setAttribute("user", "Cannot be empty!");
            errorFound = true;
        } else if(user.isEmpty() == true) {
            session.setAttribute("user", "Cannot be empty!");
            errorFound = true;
        } else {
            if(Validation.isValidUsername(user) == true) {
                account.setUserIdentifier(user);
            } else {
                session.setAttribute("user", "Invalid username!");
                errorFound = true;
            }
        }

        String email = request.getParameter("id_email");
        if(email == null) {
            session.setAttribute("email", "Cannot be empty!");
            errorFound = true;
        } else if(email.isEmpty() == true) {
            session.setAttribute("email", "Cannot be empty!");
            errorFound = true;
        } else {
            if(Validation.isValidEmail(email) == true) {
                account.setUserEmail(email);
            } else {
                session.setAttribute("email", "Invalid email address!");
                errorFound = true;
            }
        }

        String pass1 = request.getParameter("id_pass1");
        String pass2 = request.getParameter("id_pass2");
        if(pass1 == null) {
            session.setAttribute("pass1", "Cannot be empty!");
            errorFound = true;
        } else if(pass1.isEmpty() == true) {
            session.setAttribute("pass1", "Cannot be empty!");
            errorFound = true;
        } else if(pass1.length() < 5) {
            session.setAttribute("pass1", "Password length must be at least 5 characters.");
            errorFound = true;
        } else if(pass2 == null) {
            session.setAttribute("pass2", "Cannot be empty!");
            errorFound = true;
        } else if(pass2.isEmpty() == true) {
            session.setAttribute("pass2", "Cannot be empty!");
            errorFound = true;
        } else if (pass1.equals(pass2) == false) {
            session.setAttribute("pass1", "Passwords must be the same!");
            errorFound = true;
        } else {
            if(Validation.isValidPassSimple(pass1, pass2) == true) {
                account.setPasswordHashed(pass1);
            } else {
                session.setAttribute("pass1", "Invalid password!");
                errorFound = true;
            }
        }

        if(errorFound == true) {
            session.setAttribute("Company", company);
            session.setAttribute("Account", account);
            response.sendRedirect("RegisterForm.jsp");
        } else {
            account.setUserRole("CR");
            account.setAccountStatus(1);
            
            if(userBean.addAccount(account) == false) {
                out.println("An unexpected error has occured while registering the account.");
                errorFound = true;
            }
            company.setUserId(userBean.getAccount(account.getUserIdentifier()).getUserId());
            if(userBean.addCompany(company) == false) {
                out.println("An unexpected error has occured while registering the company.");
                errorFound = true;
            }
            
            if(errorFound == false) {
                userBean.logIn(user, pass1);
            }
        }
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
          <% 
            if(userBean.isLogged()) {
              if(userBean.getLoggedUser().getUserRole().equals("CR")){
          %>
			      <li><a href="#">Current Semester Teams</a></li>
		        <li><a href="ProjectAgreementForm.jsp">Create New Project</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ViewCompanyProjects.jsp">Your Projects</a></li>
            <li><a href="#">Edit Company Info</a></li>
          <%
              }
              else if(userBean.getLoggedUser().getUserRole().equals("TL")){
                if(userBean.getTeam().getHasRegistered() == 1){
          %>
            <li><a href="#">Rank Projects</a></li>
            <li><a href="#">View Projects</a></li>
            <li><a href="#">Manage Team Page</a></li>
          <%
                }
                else {
                  response.sendRedirect("/PRJ666-Implementation/pages/Team/publishTeamPage.jsp");  
                }
              }
              else if(userBean.getLoggedUser().getUserRole().equals("IN")){
          %>
            <li><a href="#">Create Team Accounts</a></li>
            <li><a href="#">Deactivate Team Accounts</a></li>
		        <li><a href="#">Match Teams/Projects</a></li>
            <li><a href="#">Match Teams/Projects Manually</a></li>
		        <li><a href="#">Pending Projects</a></li>
            <li><a href="#">Approved Projects</a></li>
            <li><a href="#">Proceed Projects</a></li>
          <%
              }
              else if(userBean.getLoggedUser().getUserRole().equals("SU")){   
          %>
            <li><a href="#">Change Project Status to Past</a></li>
		        <li><a href="#">Current Semester Available Projects</a></li>
          <%
              }
              else if(userBean.getLoggedUser().getUserRole().equals("AD")){
		      %>
            <li><a href="#">Pending Comments</a></li>
            <li><a href="#">Available Projects</a></li>
            <li><a href="#">Change Project Status to Past</a></li>
            <li><a href="#">Manage Site Accounts</a></li>
          <%
              }
          %>
          </ul>
          <div style="float: right;">
            <ul>
              <li><a href="/PRJ666-Implementation/pages/logout.jsp">Logout</a></li>
          <%
            }
            else {
          %>
              <li><a href="/PRJ666-Implementation/pages/login.jsp">Login</a></li>
              <li><a href="../archived.jsp">Archived Projects</a></li>
              <li><a href="/PRJ666-Implementation/pages/Company/AgreementForm.jsp">Company Registration</a></li>
          <% } %>
            </ul>
          </div>
        </td>
      </tr>
      <tr>
        <td>
        <%
            /*
            out.print(account.getUserId() + "<br/>");
            out.print(account.getUserIdentifier() + "<br/>");
            out.print(account.getUserFName() + "<br/>");
            out.print(account.getUserLName() + "<br/>");
            out.print(account.getUserEmail() + "<br/>");
            out.print(account.getUserRole() + "<br/>");
            out.print(account.getPassword() + "<br/>");
            out.print(account.getAccountStatus() + "<br/>");
            out.print("<br/>");
            out.print(company.getCompanyId() + "<br/>");
            out.print(company.getCompanyName() + "<br/>");
            out.print(company.getCompanyPhone() + "<br/>");
            out.print(company.getUserId() + "<br/>");
            */
            
            if(errorFound == false) {
                //userBean.setLoggedUser(account);
                out.println("<h1>Company Account has been successfully registered!</h1>");
                out.println("<a href=\"ProjectAgreementForm.jsp\">Click here to propose a project!</a>");
                session.removeAttribute("Company");
                session.removeAttribute("Account");
            }
        %>
        </td>
      </tr>          
    </table>
  </body>
</html>
