<%-- 
    Document   : matchTeam
    Created on : Mar 18, 2012, 9:53:22 AM
    Author     : matthewschranz
--%>

<%@page import="seneca.projectManagement.entity.Projects"%>
<%@page import="seneca.projectManagement.entity.Teammember"%>
<%@page import="java.util.Calendar"%>
<%@page import="seneca.projectManagement.entity.Teams"%>
<%@page import="java.util.List"%>
<%@page import="seneca.projectManagement.entity.Accounts"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<jsp:setProperty name="userBean" property="*" />
<%
    if(userBean.isLogged() == true && userBean != null) {
        if(userBean.getLoggedUser().getUserRole().equals("IN") == false) {
            session.setAttribute("Error", "You don't have permission to access the instructor page.");
            response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
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
    <title>Instructor - Matching</title>
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
          <div style="margin:2px; width:350px;">
            <script type="text/javascript"> 
		          new TWTR.Widget( {
  		          version: 2,
  		          type: "profile",
  		          rpp: 5,
 		            interval: 6000,
  		          width: 350,
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
            
            String tId = request.getParameter("Team") != null ? request.getParameter("Team") : session.getAttribute("Team").toString();
            Teams t = userBean.getTeam(Integer.parseInt(tId));
            List<Projects> projects = userBean.getAllProjects("AV");
            
            if(projects != null){
              Projects p = null;
          %>
          <h3 class="title">Select a Project for Team <%= t.getTeamName() %></h3>
          <form name="form1" method="POST" action="../validation/processInstructor.jsp">
            <div style="width: 500px">
              <div>
                <div style="float: left; width: 150px">Team Name: </div>
                <div style="float: left">
                  <select name="selectedProject">
                    <option value="0" selected>Please Select a Project</option>
                    <%
                      for(int i = 0, len = projects.size(); i < len; i++){
                        p = projects.get(i);
                        out.println("<option value='" + p.getProjectId() + "'>" + p.getPrjName() + "</option>");
                      }
                    %>
                  </select>
                </div>
                <div style="clear: both"></div>
                <%
                  if(session.getAttribute("matchFail") != null){
                    out.println("<div style='float: left; color: red;'>");
                    out.println(session.getAttribute("matchFail").toString());
                    out.println("</div><div style='clear: both'></div>");
                    session.removeAttribute("matchFail");
                  }
                %>
              </div>
              <div style="background-color: #D5E7E9; padding: 5px; text-align: right;">
                <input type="hidden" name="teamId" value="<%= tId %>" />
                <input type="submit" name="matchTeam" value="Match Team with Project" />
              </div>
            </div>
          </form>
          <%
          } else {
            out.println("<h3>There are no available projects currently.</h3>");
          }
          %>
        </td>
      </tr>             
    </table>
  </body>
</html>
