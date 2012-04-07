<%-- 
    Document   : redirect
    Created on : Feb 7, 2012, 2:57:41 PM
    Author     : KepneR
--%>

<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%@page contentType="text/html" pageEncoding="UTF-8" import="seneca.projectManagement.entity.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <%
            if(userBean.logIn( request.getParameter("username"), request.getParameter("password"))) {
                Accounts a = userBean.getLoggedUser();
                String roleFilter = a.getUserRole();
                
                if(a.getAccountStatus() == 0){
                    System.out.println("in error");
                    session.setAttribute("Error", "Account is no longer active. Please contact an administrator.");
                    userBean.setLoggedUser(null);
                    response.sendRedirect("../login.jsp");
                }
                else if(roleFilter.equals("AD")) {
                    response.sendRedirect("../Admin/HomeAdmin.jsp");
                }
                else if(roleFilter.equals("CR")) {
                    response.sendRedirect("../Company/HomeCompany.jsp");
                }
                else if(roleFilter.equals("IN")) {
                    response.sendRedirect("../Instructor/HomeInstructor.jsp");
                }
                else if(roleFilter.equals("SU")) {
                    response.sendRedirect("../Supervisor/HomeSupervisor.jsp");
                }
                else if(roleFilter.equals("TL")) {
                  Teams team = userBean.getTeam();
                  if(team.getHasRegistered() == 0) {
                    response.sendRedirect("../Team/publishTeamPage.jsp");
                  }
                  else {
                    response.sendRedirect("../Team/teamHome.jsp");
                  }
                }
                else {
                    response.sendRedirect("../Home.jsp");
                }
            }
            else {
                session.setAttribute("Error", "Invalid credentials");
                response.sendRedirect("../login.jsp");
            }
        %>
        
    </body>
</html>
