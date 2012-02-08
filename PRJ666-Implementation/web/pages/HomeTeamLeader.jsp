<%-- 
    Document   : TeamLeader
    Created on : Feb 7, 2012, 3:34:20 PM
    Author     : KepneR
--%>

<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%
    if(userBean.getIsLogged() == true) {
        if(userBean.getHasRegistered() == 0) {
            response.sendRedirect("/PRJ666-Implementation/pages/HomePublish.jsp");
        }
        if(userBean.getUserRole().equals("TL") == false) {
            session.setAttribute("Error", "You don't have permission to access the team leader page.");
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="/pages/headers/loginHeader.jsp" />
        <h1>Hello World!</h1>
        <h2>Team Leader Page</h2>
    </body>
</html>
