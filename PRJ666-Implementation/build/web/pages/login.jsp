<<<<<<< HEAD
<%-- 
    Document   : login
    Created on : Jan 26, 2012, 10:29:09 PM
    Author     : matthewschranz
--%>

<%@ page
  import="seneca.projectManagement.utils.CryptoUtil,
    seneca.projectManagement.databaseClasses.Accounts,
    java.sql.SQLException"
  language="java" contentType="text/html; charset=ISO-8859-1"
  pageEncoding="ISO-8859-1"%>
  
  <jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession"
               scope="session" />
  <jsp:setProperty name="userBean" property="*" />

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
  </head>
  <body>
    <h1>Hello World!</h1>
  </body>
</html>
=======
<%-- 
    Document   : login
    Created on : Jan 26, 2012, 10:29:09 PM
    Author     : matthewschranz
--%>

<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
  </head>
  <body>
      <jsp:include page="/pages/headers/loginHeader.jsp" />
      <%
        if(userBean.getIsLogged() == false) {
      %>
        <form method="POST" action="/PRJ666-Implementation/pages/redirect.jsp">
            Username: <input id="username" name="username" type="text" value="evan.weaver" /><br/>
            Password: <input id="password" name="password" type="password" value="12345" /><br/>
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
      %>
        Do you want to <a href="/PRJ666-Implementation/pages/logout.jsp">logout</a>?<br/>
      <%
        }
      %>
  </body>
</html>
>>>>>>> a9f7ccf305cdd20e5c7043d19fdc3028e87a7e60
