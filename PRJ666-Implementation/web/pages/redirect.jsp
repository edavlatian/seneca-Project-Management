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
                    response.sendRedirect("/PRJ666-Implementation/pages/HomeAdmin.jsp");
                }
                else if(roleFilter.equals("CR")) {
                    response.sendRedirect("/PRJ666-Implementation/pages/HomeCompany.jsp");
                }
                else if(roleFilter.equals("IN")) {
                    response.sendRedirect("/PRJ666-Implementation/pages/HomeInstructor.jsp");
                }
                else if(roleFilter.equals("SU")) {
                    response.sendRedirect("/PRJ666-Implementation/pages/HomeSupervisor.jsp");
                }
                else if(roleFilter.equals("TL")) {
                    response.sendRedirect("/PRJ666-Implementation/pages/HomeTeamLeader.jsp");
                }
                else {
                    response.sendRedirect("/PRJ666-Implementation/pages/Home.jsp");
                }
            }
            else {
                session.setAttribute("Error", "Invalid credentials");
                response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
            }
        %>
    </body>
</html>
