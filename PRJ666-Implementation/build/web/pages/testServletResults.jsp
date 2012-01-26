<%-- 
    Document   : testServletResults
    Created on : Jan 25, 2012, 9:17:44 PM
    Author     : matthewschranz
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import="seneca.projectManagement.databaseClasses.Accounts"%>
<%
  /*
   * Here is where you can do a check to see the logged in users role. 
  */     
  Accounts user = (Accounts) request.getAttribute("userAccount");
  /*
    if(user){
 *    if(user.getUserrole() == "TL") {
 *      Etc other code here and stuff
 *    }
 *  }
  */ 
%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
  </head>
  <body>
    
    User Last Name: <br/>
    User Email: <br/>
  </body>
</html>
