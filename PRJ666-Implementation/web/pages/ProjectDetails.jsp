<%-- 
    Document   : ProjectDetails
    Created on : Mar 12, 2012, 9:15:32 PM
    Author     : KepneR
--%>

<%@page import="seneca.projectManagement.utils.ProjectSorting"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%@page contentType="text/html" pageEncoding="UTF-8" import="seneca.projectManagement.entity.*"%>
<%
    boolean errorFound = false;
    if(session.getAttribute("First") == null) {
        response.sendRedirect("archived.jsp");
        errorFound = true;
    } else {
        session.removeAttribute("First");
    }
    if(userBean == null) {
        errorFound = true;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="resources/css/pageStuff.css" />
        <script type="text/javascript" src="resources/js/twitter.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PRJ566 - Archived Project Details</title>
        <script language="JavaScript">
            function collapse(x, y) {
                if(x.value == "Collapse") {
                    document.getElementById(y).style.display = "none";
                    x.value = "Expand";
                } else {
                    document.getElementById(y).style.display = "block";
                    x.value = "Collapse";
                }
            }
        </script>
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
              <li><a href="/PRJ666-Implementation/pages/archived.jsp">Archived Projects</a></li>
              <li><a href="/PRJ666-Implementation/pages/Company/AgreementForm.jsp">Register<br/>Company</a></li>
              <li><a href="/PRJ666-Implementation/pages/About.jsp">About</a></li>
          <% } %>
            </ul>
          </div>
        </td>
      </tr>
      <tr>
        <td>
            <%
                if(errorFound == false) {
            %>
                <%
                    String s = request.getParameter("Project");
                    Projects p = null;
                    try {
                        p = userBean.getProject(new Integer(s));
                    } catch (Exception e) {}
                    if(p == null)
                        return;
                    List<Projectfile> pf = userBean.getProfileFiles(p.getProjectId());
                    Company c = userBean.getCompanyByID(p.getCompanyId());

                    session.removeAttribute("First");
                %>
                <h1><%= p.getPrjName() %> Project Details</h1>
                <form name="form1">
                <div style="width: 900px">
                    <div style='font-weight: bold; color: white; background-color: #6F93C9; padding: 5px;'>
                        <div style="float: left">Project Information:</div>
                        <div style="float: right"><input type="button" value="Collapse" name="btnProject" onclick="collapse(this, '_0')" /></div>
                        <div style="clear: both"></div>
                    </div>
                    <div style='background-color: skyblue; padding: 10px' id="_0">
                        <div style="float: left; width: 150px"><b>Project Name:</b></div>
                            <div style="float: left; width: 730px"><%= p.getPrjName() %></div>
                            <div style="clear: both"></div>
                        <div style="float: left; width: 150px"><b>Description:</b></div>
                            <div style="float: left; width: 730px"><%= p.getDescription() %></div>
                            <div style="clear: both"></div>
                        <div style="float: left; width: 150px"><b>Constraints:</b></div>
                            <div style="float: left; width: 730px"><%= p.getPrjConstraints() %></div>
                            <div style="clear: both"></div>
                        <div style="float: left; width: 150px"><b>Semester:</b></div>
                            <div style="float: left; width: 730px"><%= p.getPrjIdentifier() == null ? "N/A" : p.getPrjIdentifier() %></div>
                            <div style="clear: both"></div>
                    </div>

                    <div style='font-weight: bold; color: white; background-color: #6F93C9; padding: 5px;'>
                        <div style="float: left">Instructor Information:</div>
                        <div style="float: right"><input type="button" value="Expand" name="btnProject" onclick="collapse(this, '_3')" /></div>
                        <div style="clear: both"></div>
                    </div>
                    <div style='background-color: skyblue; padding: 10px; display: none' id="_3">
                        <% 
                            if(p.getInstructorId() != null) {
                                Accounts ins = userBean.getAccount(p.getInstructorId());
                        %>
                        <div style="float: left; width: 150px"><b>Instructor Name:</b></div>
                            <div style="float: left; width: 730px"><%= ins.getUserLName() + ", " + ins.getUserFName() %></div>
                            <div style="clear: both"></div>
                        <div style="float: left; width: 150px"><b>Contact Email:</b></div>
                            <div style="float: left; width: 730px">
                                <%
                                    out.print("<a href='mailto:" + ins.getUserEmail() + "'>Send Email</a>");
                                %>
                            </div>
                            <div style="clear: both"></div>
                        <% } else { %>
                        <div>Has not yet been assigned to an Instructor!</div>
                        <% } %>
                    </div>
                    <% 
                        List<Comments> cs = userBean.getAllActiveComments(p.getProjectId());
                    %>
                    <div style='font-weight: bold; color: white; background-color: #6F93C9; padding: 5px;'>
                        <div style="float: left"><%= cs.size() %> Comment(s):</div>
                        <div style="float: right"><input type="button" value="Expand" name="btnProject" onclick="collapse(this, '_5')" /></div>
                        <div style="clear: both"></div>
                    </div>
                    <div style='background-color: skyblue; padding: 10px; display: none' id="_5">
                        <% 
                            if(cs.size() > 0) {
                            Integer x = 0; 
                            for(Comments c1 : cs) { 
                        %>
                        <div style="float: left; width: 150px"><b>Comment #<%= ++x %>:</b></div>
                            <div style="float: left; width: 730px"><%= c1.getCommentDescription() %></div>
                            <div style="clear: both"></div>
                            <div style='border-top: 1px; border-top-style: solid; border-color: lightblue'></div>
                        <%    }
                            } else {
                        %>
                        <div>No comments to display!</div>
                        <%
                            }
                        %>
                    </div>
                </div>
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
                }
            %>
        </td>
      </tr>          
    </table>
    </body>
</html>
