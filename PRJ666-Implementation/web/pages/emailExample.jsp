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
  
  emailer.sendEmail( "matthew.schranz@senecacollege.ca", "schranz.m@gmail.com",
          "Test Email", "This email is a test from the BEAM Solutions PRJ666 project"
          + " using an outside email as the recipient.");
  
  emailer.sendEmail( "matthew.schranz@senecacollege.ca", "mjschranz@learn.senecac.on.ca",
          "Test Email", "This email is a test from the BEAM Solutions PRJ666 project"
          + "using an @learn.senecac.on.ca as the recipient.");
  
  emailer.sendEmail( "emile.ohan@senecacollege.ca", "matthew.schranz@senecacollege.ca",
          "Test Email", "This email is a test from the BEAM Solutions PRJ666 project"
          + "using an @senecacollege.ca as the recipient.");
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
  </head>
  <body>
    <h3>You sent an email to mjschranz@learn.senecac.on.ca from matthew.schranz@senecacollege.ca.</h3>
    <h3>You sent an email to schranz.m@gmail.com from matthew.schranz@senecacollege.ca.</h3>
    <h3>You sent an email to matthew.schranz@senecacollege.ca from emile.ohan@senecacollege.ca.</h3>
  </body>
</html>
