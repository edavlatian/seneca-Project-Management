<%-- 
    Document   : newAccounts
    Created on : Mar 12, 2012, 2:44:33 PM
    Author     : KepneR
--%>

<%@page import="seneca.projectManagement.utils.Validation"%>
<%@page import="seneca.projectManagement.utils.CryptoUtil"%>
<%@page import="seneca.projectManagement.entity.*"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%
    Accounts a = new Accounts();
    a.setUserIdentifier("");
    a.setUserFName("");
    a.setUserLName("");
    a.setUserEmail("");
    a.setUserRole("");
    a.setAccountStatus(0);
    boolean errorFound = false;

    if(userBean.isLogged() == true && userBean != null) {
        if(userBean.getLoggedUser().getUserRole().equals("IN") == false) {
            session.setAttribute("Error", "You don't have permission to access the instructor page.");
            response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
        } else {
            String user = request.getParameter("id_user");
            if(user == null) {
                session.setAttribute("user", "Cannot be empty!");
                errorFound = true;
            } else if(user.isEmpty() == true) {
                session.setAttribute("user", "Cannot be empty!");
                errorFound = true;
            } else {
                if(Validation.isValidUsername(user) == true) {
                    a.setUserIdentifier(user);
                } else {
                    session.setAttribute("user", "Invalid username!");
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
                a.setUserFName(fname);
            }
            
            String lname = request.getParameter("id_lname");
            if(lname == null) {
                session.setAttribute("lname", "Cannot be empty!");
                errorFound = true;
            } else if(lname.isEmpty() == true) {
                session.setAttribute("lname", "Cannot be empty!");
                errorFound = true;
            } else {
                a.setUserLName(lname);
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
                    a.setUserEmail(email);
                } else {
                    session.setAttribute("email", "Invalid email address!");
                    errorFound = true;
                }
            }
            
            a.setUserRole(request.getParameter("id_role"));
            a.setAccountStatus(new Integer(request.getParameter("id_status")));
            
            if(errorFound == true) {
                session.setAttribute("Account", a);
                response.sendRedirect("CreateTeam.jsp");
            }
        }
    }
    else {
        response.sendRedirect("/PRJ666-Implementation/pages/Home.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
    <title>Instructor</title>
  </head>
  <body>
    <table> 
      <tr>
        <td colspan="2">
          <table width="100%">
            <tr>
              <td width="402" style="background-image: url('../resources/images/header_left.jpg'); background-repeat: no-repeat;"></td>
              <td style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;" width="800">
                <a href="/PRJ666-Implementation/pages/Home.jsp" style="color: black;"><center><h2>WELCOME TO PRJ566<br/> Project Planning and Management</h2></center></a>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr valign="top">
        <td rowspan="5" align="left" width="200"> 
          <img src="../resources/images/seneca_logo.gif" title="Seneca logo"/>
          <br/>
          <img src="../resources/images/ICT_Logo.png" title="ICT Logo"/>
          <br/>
          <%
          if(userBean != null) {
            if(userBean.isLogged() == true) {
              Accounts temp_a = userBean.getLoggedUser();
              out.println("<hr width='95%' align='left'/>");
              out.print("Hello Instructor, " + temp_a.getUserFName() + " " + temp_a.getUserLName());
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
        <td style="background-image: url('../resources/images/header_bg.jpg'); height: 1px;">
          <ul>
            <li style="width: 10%;"><a href="InstructorHome.jsp">Instructor<br/>Home</a></li>
            <li style="width: 10%;"><a href="CreateTeam.jsp">Create<br/>Team<br/>Accounts</a></li>
            <li style="width: 10%;"><a href="#">Deactivate<br/>Team<br/>Accounts</a></li>
            <li style="width: 10%;"><a href="#">Match<br/>Teams<br/>Projects</a></li>
		        <li style="width: 10%;"><a href="PendingProjects.jsp">Pending<br/>Projects</a></li>
            <li style="width: 10%;"><a href="ApprovedProjects.jsp">Approved<br/>Projects</a></li>
            <li style="width: 10%;"><a href="#">Change<br/>Project<br/>Status</a></li>
            <li><a href="../logout.jsp">Logout</a></li>
          </ul>
        </td>
      </tr>
      <tr>
        <td>
            <h1>Create Team Account</h1>
            <%
                if(errorFound != true) {
                    String pass = CryptoUtil.generateRandomPassword();
                    a.setPasswordHashed(pass);
                    if(userBean.addTeam(a) == true) {
                        out.println("Account for " + a.getUserFName() + " " + a.getUserLName() + " has been successfully created.<br/>");
                        out.println("<div style='padding: 10px; background-color: skyblue;'>");
                        out.println("Username: <b>" + a.getUserIdentifier() + "</b><br/>");
                        out.println("Password: <b>" + pass + "</b></div>");
                        out.println("<div style='color: red'>IMPORTANT: Please write down or keep a backup of your account information.</div>");
                    } else {
                        out.println("An unexpected error has occured while creating new account.");
                    }
                    
                    session.removeAttribute("Account");
                }
            %>
        </td>
      </tr>             
    </table>
  </body>
</html>
