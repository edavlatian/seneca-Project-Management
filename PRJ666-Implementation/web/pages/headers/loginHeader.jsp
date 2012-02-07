<%-- 
    Document   : loginHeader
    Created on : Feb 7, 2012, 3:47:37 PM
    Author     : KepneR
--%>

<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<div style="text-align: right; width: 100%; background-color: #CCCCCC;">
    <%
        if(userBean.getIsLogged() == true) {
            out.print("<a href=\"/PRJ666-Implementation/pages/logout.jsp\">Logout</a>");
        }
        else {
            out.print("<a href=\"/PRJ666-Implementation/pages/login.jsp\">Login</a>");
        }
    %>
</div>
