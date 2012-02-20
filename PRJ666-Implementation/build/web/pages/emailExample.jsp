<%-- 
    Document   : emailExample
    Created on : Feb 18, 2012, 2:01:06 PM
    Author     : matthewschranz
--%>
<%@page import="seneca.projectManagement.utils.Email"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
  Email emailer = new Email();
  
  emailer.sendEmail( "schranz.m@gmail.com", "mjschranz@learn.senecac.on.ca",
          "Test Email", "This email is a test from the BEAM Solutions PRJ666 project.");
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
  </head>
  <body>
    <h1>You sent an email to mjschranz@learn.senecac.on.ca, from matthew.schranz@senecacollege.ca.</h1>
  </body>
</html>
