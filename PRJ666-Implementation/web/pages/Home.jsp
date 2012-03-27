<%--
Document   : Home
    Created on : Feb 7, 2012, 3:35:32 PM
    Author     : KepneR
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="seneca.projectManagement.entity.News"%>
<%@page import="java.util.List"%>
<%@page import="seneca.projectManagement.entity.Teams"%>
<%@page import="seneca.projectManagement.entity.Company"%>
<%@page import="seneca.projectManagement.entity.Accounts"%>
<%@page import="seneca.projectManagement.utils.CryptoUtil"%>
<%@page import="seneca.projectManagement.utils.Validation"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<jsp:setProperty name="userBean" property="*" />
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="resources/css/pageStuff.css" />
    <script type="text/javascript" src="resources/js/twitter.js"></script>
    <title>PRJ566 - Home</title>
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
        <td rowspan="100" align="left" width="200"> 
          <img src="resources/images/seneca_logo.gif" title="Seneca logo"/>
          <br/>
          <img src="resources/images/ICT_Logo.png" title="ICT Logo"/>
          <br/>
          <%
          if(userBean != null) {
            if(userBean.isLogged() == true) {
              Accounts temp_a = userBean.getLoggedUser();
              out.println("<hr width='95%' align='left'/>");
              if(temp_a.getUserRole().equals("AD")) {
                out.print("Hello Administrator, " + temp_a.getUserFName() + " " + temp_a.getUserLName());
              } else if(temp_a.getUserRole().equals("CR")) {
                Company temp_c = userBean.getCompany();
                out.print("Hello, Company " + temp_c.getCompanyName());
              } else if(temp_a.getUserRole().equals("IN")) {
                out.print("Hello Instructor, " + temp_a.getUserFName() + " " + temp_a.getUserLName());
              } else if(temp_a.getUserRole().equals("SU")) {
                out.print("Hello Supervisor, " + temp_a.getUserFName() + " " + temp_a.getUserLName());
              } else if(temp_a.getUserRole().equals("TL")) {
                Teams temp_t = userBean.getTeam();
                out.print("Hello, Team " + temp_t.getTeamName());
              }
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
        <td style="background-image: url('resources/images/header_bg.jpg')">
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
              <li><a href="/PRJ666-Implementation/pages/login.jsp">Login</a></li>
              <li><a href="/PRJ666-Implementation/pages/archived.jsp">Archived<br/>Projects</a></li>
              <li><a href="/PRJ666-Implementation/pages/Company/AgreementForm.jsp">Register<br/>Company</a></li>
              <li><a href="/PRJ666-Implementation/pages/About.jsp">About</a></li>
          <% } %>
            </ul>
        </td>
      </tr>
      <%
        if(session.getAttribute("Error") != null){
      %>
          <tr><td style="color: red;">
            <%= session.getAttribute("Error").toString() %>
          </td></tr>
      <%
          session.removeAttribute("Error");
        }
      %>
      <tr>
        <td style='padding-left: 5px'>
          <%
            List<News> allNews = userBean.getRecentNews();
            News n = null;
            Accounts a = null;
            
            if(allNews != null){
              for(int i = 0; i < allNews.size(); i++){
                n = allNews.get(i);
                a = userBean.getAccount(n.getInstructorId());
                out.println("<h3 class='title'>" + n.getPostTitle() + "</h3>By: " + a.getUserFName() + " " + a.getUserLName() +
                        "<br/>Date: " + new SimpleDateFormat("MM/dd/yyyy").format(n.getPostDate()));
                out.println("<p style='padding: 5px;'>" + n.getPostText() + "</p><hr/>");
              }
            }
            else
              out.println("There is no news available, or the query failed! =(");
          %>
        </td>
      </tr>
    </table>
  </body>
</html>
