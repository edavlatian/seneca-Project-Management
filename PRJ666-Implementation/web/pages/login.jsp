<%-- 
    Document   : Home
    Created on : Feb 7, 2012, 3:35:32 PM
    Author     : KepneR
--%>

<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%@page contentType="text/html" pageEncoding="UTF-8" import="seneca.projectManagement.entity.*"%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="resources/css/pageStuff.css" />
    <link rel="stylesheet" type="text/css" href="resources/css/jquery-ui-1.8.16.custom.css" />
    <script type="text/javascript" src="resources/js/twitter.js"></script>
    <script type="text/javascript" src="resources/js/jquery-ui.js"></script>
    <title>PRJ566 - Home</title>
  </head>
  <body>
    <table> 
      <tr>
        <td colspan="2">
          <table width="100%">
            <tr>
              <td width="402" style="background-image: url('resources/images/header_left.jpg'); background-repeat: no-repeat;">&nbsp;</td>
              <td style="background-image: url('resources/images/header_bg.jpg'); background-repeat: repeat;" width="800"><center><h2>WELCOME TO PRJ566<br/> Project Planning and Management</h2></center></td>
            </tr>
          </table>
        </td>
      </tr>
      <tr valign="top">
        <td rowspan="5" align="left" width="200"> 
          <img src="resources/images/seneca_logo.gif" title="Seneca logo"/>
          <br/>
          <img src="resources/images/ICT_Logo.png" title="ICT Logo"/>
          <br/>
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
        <td style="background-image: url('resources/images/header_bg.jpg')">
          <ul>
          <% 
            if(userBean.isLogged()) {
              if(userBean.getLoggedUser().getUserRole().equals("CR")){
          %>
			      <li><a href="#">Current Semester Teams</a></li>
		        <li><a href="#">Create New Project</a></li>
            <li><a href="Company/ViewCompanyProjects.jsp">Your Projects</a></li>
            <li><a href="#">Upcoming Milestones</a></li>
            <li><a href="#">Edit Company Info</a></li>
          <%
              }
              else if(userBean.getLoggedUser().getUserRole().equals("TL")){
                if(userBean.getTeam().getHasRegistered() == 1){
          %>
            <li><a href="#">Rank Projects</a></li>
		        <li><a href="#">Manage Project Milestones</a></li>
            <li><a href="#">View Projects</a></li>
            <li><a href="#">Manage Team Page</a></li>
          <%
                }
                else {
                  response.sendRedirect("Team/publishTeamPage.jsp");  
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
              <li><a href="logout.jsp">Logout</a></li>
          <%
            }
            else {
          %>
              <li><a href="login.jsp">Login</a></li>
              <li><a href="register.jsp">Register</a></li>
              <li><a href="Company/AgreementForm.jsp">Company Registration</a></li>
          <% } %>
            </ul>
          </div>
        </td>
      </tr>
      <tr>
        <td>
            <div style="width: 240px; background-color: #D5E7E9; padding: 5px; margin-top: 5px">
            <%
                if(userBean.isLogged() == false) {
            %>
                <form method="POST" action="validation/redirect.jsp">
                        <div style="float: left; width: 80px; text-align: right">Username:</div>
                        <div style="float: left; width: 150px">
                            <input id="username" name="username" type="text" value="kepner.caliso" style="width: 145px"/>
                        </div>
                        <div style="clear: both"></div>
                        <div style="float: left; width: 80px; text-align: right">Password:</div>
                        <div style="float: left; width: 150px">
                            <input id="password" name="password" type="password" value="12345" style="width: 145px" />
                        </div>
                        <div style="clear: both"></div>
                        <div style="width: 230px; text-align: right"><input type="submit" value="Login Now!" /></div>
                </form>

            <%
                    if(session.getAttribute("Error") != null) {
                            out.print("<font color=\"red\">" + session.getAttribute("Error").toString() + "</font>");
                            userBean.logout();
                            session.invalidate();
                    }
                } else {
                    if(session.getAttribute("Error") != null) {
                        out.print("<font color=\"red\">" + session.getAttribute("Error").toString() + "</font><br/>");
                    }
                    String roleFilter = userBean.getLoggedUser().getUserRole();

                    if(roleFilter.equals("AD")) {
                    response.sendRedirect("Admin/HomeAdmin.jsp");
                    }
                    else if(roleFilter.equals("CR")) {
                    response.sendRedirect("Company/HomeCompany.jsp");
                    }
                    else if(roleFilter.equals("IN")) {
                    response.sendRedirect("Instructor/HomeInstructor.jsp");
                    }
                    else if(roleFilter.equals("SU")) {
                    response.sendRedirect("Supervisor/HomeSupervisor.jsp");
                    }
                    else if(roleFilter.equals("TL")) {
                        Teams team = userBean.getTeam();
                        if(team.getHasRegistered() == 0) {
                            response.sendRedirect("Team/publishTeamPage.jsp");
                        }
                        else {
                            response.sendRedirect("Team/teamHome.jsp");
                        }
                    }
                }
            %>
            </div>
        </td>
      </tr>          
    </table>
  </body>
</html>