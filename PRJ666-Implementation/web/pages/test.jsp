<%-- 
    Document   : test
    Created on : Feb 20, 2012, 8:44:46 PM
    Author     : matthewschranz
--%>

<%@page import="seneca.projectManagement.persistence.PersistenceController"%>
<%@page import="seneca.projectManagement.entity.Accounts"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
  Accounts account = new Accounts();
  account.setUserIdentifier("temp.test");
  account.setUserFName("test");
  account.setUserLName("temp");
  account.setPasswordHashed("12345");
  account.setUserEmail("temp.temp@something.com");
  account.setUserRole("TL");
  
  PersistenceController pc = new PersistenceController();
  pc.addTeam( account );
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
  </head>
  <body>
    <h1>A Team Account has been created with the following information:
    <br/>
    account.setUserIdentifier("temp.test");
    <br/>
    account.setUserFName("test");
    <br/>
    account.setUserLName("temp");
    <br/>
    account.setPasswordHashed("12345");
    <br/>
    account.setUserEmail("temp.temp@something.com");
    <br/>
    account.setUserRole("TL");
    </h1>
  </body>
</html>
