<%-- 
    Document   : ProjectDetails
    Created on : Mar 12, 2012, 12:51:21 PM
    Author     : KepneR
--%>

<%@page import="seneca.projectManagement.utils.ProjectSorting"%>
<%@page import="java.util.Collections"%>
<%@page import="seneca.projectManagement.entity.*"%>
<%@page import="java.util.List"%>
<%@page import="seneca.projectManagement.utils.Validation"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%
    boolean showButton = false;
    if(userBean.isLogged() == true && userBean != null) {
        if(userBean.getLoggedUser().getUserRole().equals("IN") == false) {
            session.setAttribute("Error", "You don't have permission to access the instructor page.");
            response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
        }
    }
    else {
        response.sendRedirect("/PRJ666-Implementation/pages/Home.jsp");
    }
    
    if(request.getParameter("pending") != null) {
        showButton = true;
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
    <title>Instructor</title>
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
        <td width="355px"style="background-image: url('../resources/images/header_left.jpg'); background-repeat: no-repeat;">&nbsp;</td>
        <td width="900px" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;">
          <a href="/PRJ666-Implementation/pages/Home.jsp" style="color: black;"><center><h2>WELCOME TO PRJ566<br/> Project Planning and Management</h2></center></a>
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
            <li><a href="/PRJ666-Implementation/pages/Instructor/HomeInstructor.jsp">Instructor<br/>Home</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/CreateTeam.jsp">Create<br/>Team<br/>Accounts</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/matching.jsp">Match<br/>Teams<br/>Projects</a></li>
		        <li><a href="/PRJ666-Implementation/pages/Instructor/PendingProjects.jsp">Pending<br/>Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/ApprovedProjects.jsp">Approved<br/>Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/updateProjects.jsp">Change<br/>Project<br/>Status</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/manageTeamMembers.jsp">Manage<br/>Team<br/>Members</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/postNews.jsp">Post<br/>News</a></li>
            <li><a href="../logout.jsp">Logout</a></li>
          </ul>
        </td>
      </tr>
      <tr>
        <td>
          <%
            String s = request.getParameter("Project");
            Projects p = userBean.getProject(new Integer(s));
            List<Projectfile> pf = userBean.getProfileFiles(p.getProjectId());
            Company c = userBean.getCompanyByID(p.getCompanyId());
            
            session.setAttribute("project", p);
          %>
          <h1><%= p.getPrjName() %> Project Details</h1>
          <% if(showButton == true) {%>
          <form name="form1" method="POST" action="ProjectSetApproved.jsp">
          <% } else { %>
          <form name="form1">
          <% } %>
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
                  <div style="float: left">Project Files:</div>
                  <div style="float: right"><input type="button" value="Expand" name="btnProject" onclick="collapse(this, '_1')" /></div>
                  <div style="clear: both"></div>
              </div>
              <div style='background-color: skyblue; padding: 10px; display: none' id="_1">
                  <% if(pf.size() > 0) { 
                        for(Projectfile _pf : pf) { %>
                  <div style="float: left; width: 150px"><b>File Name:</b></div>
                    <div style="float: left; width: 730px"><%= _pf.getFileName() %></div>
                    <div style="clear: both"></div>
                  <div style="float: left; width: 150px"><b>Description:</b></div>
                    <div style="float: left; width: 730px"><%= _pf.getFileDescription() %></div>
                    <div style="clear: both"></div>
                  <div style="float: left; width: 150px"><b>Link: </b></div>
                    <div style="float: left; width: 730px">
                        <%
                            out.print("<a href='" + _pf.getTheFile() + "'>" + _pf.getTheFile() + "</a>");
                        %>
                    </div>
                    <div style="clear: both"></div>
                  <div style='border-top: 1px; border-top-style: solid; border-color: lightblue'></div>
                  <% } %>
                  <% } else { %>
                  <div>No project files to display!</div>
                  <% } %>
              </div>
              
                    
              <div style='font-weight: bold; color: white; background-color: #6F93C9; padding: 5px;'>
                  <div style="float: left">Company Information:</div>
                  <div style="float: right"><input type="button" value="Expand" name="btnProject" onclick="collapse(this, '_2')" /></div>
                  <div style="clear: both"></div>
              </div>
              <div style='background-color: skyblue; padding: 10px; display: none' id="_2">
                  <div style="float: left; width: 150px"><b>Company Name:</b></div>
                    <div style="float: left; width: 730px"><%= c.getCompanyName() %></div>
                    <div style="clear: both"></div>
                  <div style="float: left; width: 150px"><b>Description:</b></div>
                    <div style="float: left; width: 730px"><%= c.getCompanyDescription() %></div>
                    <div style="clear: both"></div>
                  <div style="float: left; width: 150px"><b>Business Areas:</b></div>
                    <div style="float: left; width: 730px"><%= c.getBusinessAreas() %></div>
                    <div style="clear: both"></div>
                  <div style="float: left; width: 150px"><b>Phone Number:</b></div>
                    <div style="float: left; width: 730px"><%= c.getCompanyPhone() %></div>
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
              
              <div style='font-weight: bold; color: white; background-color: #6F93C9; padding: 5px;'>
                  <div style="float: left">Team Information:</div>
                  <div style="float: right"><input type="button" value="Expand" name="btnProject" onclick="collapse(this, '_4')" /></div>
                  <div style="clear: both"></div>
              </div>
              <div style='background-color: skyblue; padding: 10px; display: none' id="_4">
                  <% 
                    if(p.getTeamId() != null) {
                        Teams team = userBean.getTeam(p.getTeamId());
                  %>
                  <div style="float: left; width: 150px"><b>Team Name:</b></div>
                    <div style="float: left; width: 730px"><%= team.getTeamName() %></div>
                    <div style="clear: both"></div>
                  <div style="float: left; width: 150px"><b>Description:</b></div>
                    <div style="float: left; width: 730px"><%= team.getTeamDescription() %></div>
                    <div style="clear: both"></div>
                  <div style="float: left; width: 150px"><b>Constraints:</b></div>
                    <div style="float: left; width: 730px"><%= team.getTeamConstraints() %></div>
                    <div style="clear: both"></div>
                  <div style="float: left; width: 150px"><b>Team Email:</b></div>
                    <div style="float: left; width: 730px">
                        <%
                            out.print("<a href='mailto:" + team.getTeamEmail() + "'>Send Email</a>");
                        %>
                    </div>
                    <div style="clear: both"></div>
                  <% } else { %>
                  <div>Has not yet been assigned to a Team!</div>
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
              <% if(showButton == true) {%>
                <div style="text-align: center; padding: 10px">
                    <input type="submit" value="Click here to approve this Project!" style="height: 40px; width: 250px" />
                </div>
              <% } %>
          </div>
          </form>
        </td>
      </tr>             
    </table>
  </body>
</html>
