<%-- 
    Document   : teamHome
    Created on : Feb 1, 2012, 10:05:52 AM
    Author     : matthewschranz
--%>

<%@page import="java.util.List"%>
<%@page import="seneca.projectManagement.entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
  <jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession"
               scope="session" />
  <jsp:setProperty name="userBean" property="*" />
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
    <title>PRJ566 - Team Home</title>
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
              Teams temp_t = userBean.getTeam();
              out.print("Hello, Team " + temp_t.getTeamName());
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
            <li><a href="/PRJ666-Implementation/pages/Team/manageTeamPage.jsp">Manage<br/>Team Page</a></li>
            <li><a href="/PRJ666-Implementation/pages/Team/viewProjects.jsp">View<br/>Available<br/>Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Team/teamProject.jsp">View<br/>Your<br/>Project</a></li>
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
            Teams team = userBean.getTeam();
            List<Teammember> members = userBean.getAllMembers(team.getTeamId());
            Teammember m = null;
            int count = 0;
          %>
          <div style="text-align: center;">
            <img src="<%= team.getTeamLogo() == null || team.getTeamLogo().isEmpty() ? "/PRJ666-Implementation/pages/resources/images/logoDefault.jpg" : team.getTeamLogo() %>"
                 alt="Team Logo" style="max-width: 400px; max-height: 200px;"/>
          </div>
          <div style="text-align: center; margin-bottom: 10px;">
            <a href="mailto:<%= team.getTeamEmail() %>">Email All Members</a>
          </div>
          <%
            for(int i = 0, len = members.size(); i < len; i++){
              m = members.get(i);
              %>
              <div style="text-align: center; float: left; margin-left: 5px; width: 270px; height: 400px;">
                <div style="width: 260px; height: 350px;">
                  <a href="memberPage.jsp?id=<%= m.getMemberId() %>">
                      <img src="<%= m.getMemberImage() == null || m.getMemberImage().isEmpty() ? "/PRJ666-Implementation/pages/resources/images/memberDefault.jpg" : m.getMemberImage() %>" 
                           alt="Member Image" 
                        style="max-height: 350px; max-width: 260px;"/></a>
                </div>
                <%= m.getTeamLeader() == 1 ? "Leader" : "Member" %>
                <br/>
                <a href="mailto:<%= m.getEmail() %>">Email</a>
                <br/>
                <%= m.getFirstName() + " " + m.getLastName() %>
              </div>
              <%
              if(count == 3)
                out.println("<br/>");
              count++;
            }
          %>
        </td>
      </tr>
    </table>
  </body>
</html>
