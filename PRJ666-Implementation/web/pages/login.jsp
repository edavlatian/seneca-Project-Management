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
    <script type="text/javascript" src="resources/js/twitter.js"></script>
    <title>PRJ566 - Login</title>
  </head>
  <body>
    <table> 
      <tr>
        <td width="355px"style="background-image: url('resources/images/header_left.jpg'); background-repeat: no-repeat;">&nbsp;</td>
        <td width="900px" style="background-image: url('resources/images/header_bg.jpg'); background-repeat: repeat;">
          <a href="/PRJ666-Implementation/pages/Home.jsp" style="color: black;"><center><h2>WELCOME TO PRJ566<br/> Project Planning and Management</h2></center></a>
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
        <td style="background-image: url('resources/images/header_bg.jpg'); height: 1px;">
          <div style="float: right;">
            <ul>
          <% 
            if(userBean.isLogged()) {
              if(userBean.getLoggedUser().getUserRole().equals("CR")){
          %>
			      <li><a href="#">Current Semester Teams</a></li>
		        <li><a href="#">Create New Project</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ViewCompanyProjects.jsp">Your Projects</a></li>
            <li><a href="#">Edit Company Info</a></li>
          <%
              }
              else if(userBean.getLoggedUser().getUserRole().equals("TL")){
                if(userBean.getTeam().getHasRegistered() == 1){
          %>
            <li><a href="/PRJ666-Implementation/pages/Team/teamHome.jsp">Team<br/>Home</a></li>
		        <li><a href="/PRJ666-Implementation/pages/Team/manageTeamPage.jsp">Manage<br/>Team<br/>Page</a></li>
            <li><a href="/PRJ666-Implementation/pages/Team/viewProjects.jsp">View<br/>Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Team/teamProject.jsp">View<br/>Team<br/>Project</a></li>
          <%
                }
                else {
                  response.sendRedirect("Team/publishTeamPage.jsp");  
                }
              }
              else if(userBean.getLoggedUser().getUserRole().equals("IN")){
          %>
            <li><a href="/PRJ666-Implementation/pages/Instructor/HomeInstructor.jsp">Instructor<br/>Home</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/CreateTeam.jsp">Create<br/>Team<br/>Accounts</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/matching.jsp">Match<br/>Teams<br/>Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/manageTeamMembers.jsp">Manage<br/>Team<br/>Members</a></li>
		        <li><a href="/PRJ666-Implementation/pages/Instructor/PendingProjects.jsp">Pending<br/>Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/ApprovedProjects.jsp">Approved<br/>Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/updateProjects.jsp">Change<br/>Project<br/>Status</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/postNews.jsp">Post<br/>News</a></li>
          <%
              }
              else if(userBean.getLoggedUser().getUserRole().equals("SU")){   
          %>
            <li><a href="/PRJ666-Implementation/pages/Supervisor/ProjectUpdate.jsp">Change Project Status to Past</a></li>
		        <li><a href="/PRJ666-Implementation/pages/Supervisor/AvailableProjects.jsp">Current Semester Available Projects</a></li>
          <%
              }
              else if(userBean.getLoggedUser().getUserRole().equals("AD")){
		      %>
            <li><a href="/PRJ666-Implementation/pages/Admin/HomeAdmin.jsp">Admin Home</a></li>
            <li><a href="/PRJ666-Implementation/pages/Admin/PendingComments.jsp">Pending Comments</a></li>
            <li><a href="/PRJ666-Implementation/pages/Admin/AvailableProjects.jsp">Available Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Admin/ProjectUpdate.jsp">Change Project Status to Past</a></li>
            <li><a href="/PRJ666-Implementation/pages/Admin/ManageAccounts.jsp">Manage Site Accounts</a></li>
          <%
              }
          %>
          </ul>
          <div style="float: right;">
            <ul>
              <li><a href="/PRJ666-Implementation/pages/archived.jsp">Archived<br/>Projects</a></li>
              <li><a href="/PRJ666-Implementation/pages/About.jsp">About</a></li>
              <li><a href="/PRJ666-Implementation/pages/logout.jsp">Logout</a></li>
          <%
            }
            else {
          %>
              <li><a href="/PRJ666-Implementation/pages/archived.jsp">Archived<br/>Projects</a></li>
              <li><a href="/PRJ666-Implementation/pages/About.jsp">About</a></li>
              <li><a href="/PRJ666-Implementation/pages/Company/AgreementForm.jsp">Register<br/>Company</a></li>
          <% } %>
            </ul>
          </div>
        </td>
      </tr>
      <tr>
        <td>
            <div style="width: 240px; background-color: #D5E7E9; padding: 5px; margin-top: 5px">
            <%
                if(!userBean.isLogged()) {
            %>
                <form method="POST" action="validation/redirect.jsp">
                        <div style="float: left; width: 80px; text-align: right">Username:</div>
                        <div style="float: left; width: 150px">
                            <input id="username" name="username" type="text" value="" style="width: 145px"/>
                        </div>
                        <div style="clear: both"></div>
                        <div style="float: left; width: 80px; text-align: right">Password:</div>
                        <div style="float: left; width: 150px">
                            <input id="password" name="password" type="password" value="" style="width: 145px" />
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
