<%-- 
    Document   : logout
    Created on : Feb 7, 2012, 4:07:18 PM
    Author     : KepneR
--%>

<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%
    userBean.logout();
    session.invalidate();
    response.sendRedirect("Home.jsp");
%>