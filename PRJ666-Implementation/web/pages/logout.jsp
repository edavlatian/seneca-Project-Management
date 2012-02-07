<%-- 
    Document   : logout
    Created on : Feb 7, 2012, 4:07:18 PM
    Author     : KepneR
--%>

<%
    session.invalidate();
    response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
%>