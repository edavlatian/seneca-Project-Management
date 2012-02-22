<%-- 
    Document   : login
    Created on : Jan 26, 2012, 10:29:09 PM
    Author     : matthewschranz
--%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession"
               scope="session" />
<jsp:setProperty name="userBean" property="*" />

<%@page contentType="text/html" pageEncoding="UTF-8" import="seneca.projectManagement.entity.*"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Page</title>
  </head>
  <body>
      <jsp:include page="headers/loginHeader.jsp" />
      <%
        if(userBean.isLogged() == false) {
      %>
        <form method="POST" action="validation/redirect.jsp">
            Username: <input id="username" name="username" type="text" value="" /><br/>
            Password: <input id="password" name="password" type="password" value="" /><br/>
            <input type="submit" value="Login Now!" />
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
  </body>
</html>
