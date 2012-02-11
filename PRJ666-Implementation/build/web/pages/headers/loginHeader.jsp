<%-- 
    Document   : loginHeader
    Created on : Feb 7, 2012, 3:47:37 PM
    Author     : KepneR
--%>

<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<div style="text-align: right; width: 100%; background-color: #CCCCCC; margin: 0px; padding: 0px; border: 0px">
    <%
        if(userBean.getIsLogged() == true) {
            out.print("<a href=\"/PRJ666-Implementation/pages/logout.jsp\">Logout</a>&nbsp;&nbsp;");
        }
        else {
            out.print("<a href=\"/PRJ666-Implementation/pages/login.jsp\">Login</a>&nbsp;&nbsp;");
        }
    %>
</div>
