<%-- 
    Document   : redirect
    Created on : Feb 7, 2012, 2:57:41 PM
    Author     : KepneR
--%>

<%@page import="seneca.projectManagement.databaseClasses.Accounts"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<jsp:setProperty name="userBean" property="*" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <%
            if(userBean.logIn()) {
                String roleFilter = userBean.getLoggedUser().getUserrole();
                if(roleFilter.equals("AD")) {
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
                    if(userBean.getHasRegistered() == 0) {
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
