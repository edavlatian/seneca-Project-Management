<%-- 
    Document   : About
    Created on : Mar 24, 2012, 9:37:11 AM
    Author     : KepneR
--%>

<%@page import="seneca.projectManagement.entity.Teams"%>
<%@page import="seneca.projectManagement.entity.Company"%>
<%@page import="seneca.projectManagement.entity.Accounts"%>
<%@page import="seneca.projectManagement.utils.CryptoUtil"%>
<%@page import="seneca.projectManagement.utils.Validation"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<jsp:setProperty name="userBean" property="*" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
			      <li><a href="/PRJ666-Implementation/pages/Company/HomeCompany.jsp">Company Home</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ProjectAgreementForm.jsp">Create New Project</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ViewCompanyProjects.jsp">Your Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ManageCompanyInfo.jsp">Edit Company Info</a></li>
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
              <li><a href="/PRJ666-Implementation/pages/logout.jsp">Logout</a></li>
          <%
            }
            else {
          %>
              <li><a href="/PRJ666-Implementation/pages/login.jsp">Login</a></li>
              <li><a href="/PRJ666-Implementation/pages/archived.jsp">Archived<br/>Projects</a></li>
              <li><a href="/PRJ666-Implementation/pages/Company/AgreementForm.jsp">Register<br/>Company</a></li>
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
        <td>
            <h1>Contact Info</h1>
            <div>
                <div style="padding-left: 10px; font-weight: bold;">
                    70 The Pond Road<br/>
                    Toronto, Ontario M3J 3M6<br/>
                    Canada
                </div>
            </div>
            <h1>Project Course</h1>
            <div>
                <div><b><u><a href="https://scs.senecac.on.ca/course/prj566" target="_blank">PRJ566 - Project Planning and Management</a></u></b></div>
                <div style="padding: 10px">
                    In this course students are required to select a project that involves developing a computer system. 
                    <br/>Students learn project management concepts while carrying out requirements gathering, analysis, 
                    <br/>design, and implementation planning for the identified system. Project management concepts learned 
                    <br/>include scope development and management, creation of work breakdown structures including task 
                    <br/>dependencies, and cost benefit analysis using return on investment and payback. Students create 
                    <br/>dialogue maps and mock-ups of user interfaces for their systems, and use a modeling tool to create 
                    <br/>detailed software models which they then go on to implement in PRJ666.
                </div>
                <div><b><u><a href="https://scs.senecac.on.ca/course/prj666" target="_blank">PRJ666 - Project Implementation</a></u></b></div>
                <div style="padding: 10px">
                    This is the final course in the systems' stream in which students complete the development and 
                    <br/>implementation phase of a project. As part of a team, students will plan and manage the 
                    <br/>development of an actual system using project planning, system design, system implementation, 
                    <br/>and unit and system testing methodologies. Students will also integrate and apply the 
                    <br/>object-oriented concepts, tools and techniques learned in previous courses, and create 
                    <br/>appropriate documentation for the completed system.
                </div>
            </div>
            <h1>Related Links</h1>
            <div style="padding-left: 10px;">
                <div><b><u><a href="http://senecacollege.ca/" target="_blank">http://senecacollege.ca/</a></u></b></div>
                <div><b><u><a href="https://scs.senecac.on.ca/" target="_blank">https://scs.senecac.on.ca/</a></u></b></div>
            </div>
        </td>
      </tr>
    </table>
  </body>
</html>