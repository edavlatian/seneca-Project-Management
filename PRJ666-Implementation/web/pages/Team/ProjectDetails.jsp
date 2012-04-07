<%-- 
    Document   : ProjectDetails
    Created on : Mar 13, 2012, 11:06:04 PM
    Author     : matthewschranz
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="seneca.projectManagement.utils.ProjectSorting"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%@page contentType="text/html" pageEncoding="UTF-8" import="seneca.projectManagement.entity.*"%>
<%
    if(userBean.isLogged() == true && userBean != null) {
        if(userBean.getLoggedUser().getUserRole().equals("TL")) {
          if(userBean.getTeam().getHasRegistered() != 1)
            response.sendRedirect("publishTeamPage.jsp");
        }
        else if(userBean.getLoggedUser().getAccountStatus() != 1) {
          session.setAttribute("Error", "Account has not been activated yet.");
          response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
        }
    }
    else {
        response.sendRedirect("/PRJ666-Implementation/pages/Home.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
        <script type="text/javascript" src="../resources/js/twitter.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PRJ566 - Available Project Details</title>
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
            <li><a href="/PRJ666-Implementation/pages/Team/teamHome.jsp">Team<br/>Home</a></li>
            <li><a href="/PRJ666-Implementation/pages/Team/manageTeamPage.jsp">Manage<br/>Team<br/>Page</a></li>
            <li><a href="/PRJ666-Implementation/pages/Team/viewProjects.jsp">View<br/>Available<br/>Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Team/teamProject.jsp">View<br/>Team<br/>Project</a></li>
          </ul>
          <div style="float: right;">
            <ul>
              <li><a href="../logout.jsp">Logout</a></li>
            </ul>
          </div>
        </td>
      </tr>
      <tr>
        <td>
                <%
                    String s = request.getParameter("Project");
                    Projects p = null;
                    try {
                        p = userBean.getProject(new Integer(s));
                    } catch (Exception e) {}
                    if(p == null)
                        return;
                    Company c = userBean.getCompanyByID(p.getCompanyId());
                    Accounts a = userBean.getAccount(c.getUserId());
                %>
                <h3 class="title">Company Info</h3>
                <span class="teamHeaders">Company Name:&nbsp;</span><%= c.getCompanyName() %> <br/>
                <span class="teamHeaders">Contact Person:&nbsp;</span><%= a.getUserFName() + " " + a.getUserLName() %><br/>
                <span class="teamHeaders">Business Areas:&nbsp;</span><p class="description"><%= c.getBusinessAreas() %></p>
                <h3 class="title">Project Info</h3>
                <span class="teamHeaders">Name:&nbsp;</span><%= p.getPrjName() %><br/>
                <span class="teamHeaders">Constraints:&nbsp;</span><p class="description"><%= p.getPrjConstraints() %></p>
                <span class="teamHeaders">Description:&nbsp;</span><p class="description"><%= p.getDescription() %></p>
        </td>
      </tr>          
    </table>
  </body>
</html>

