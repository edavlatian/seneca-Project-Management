<%-- 
    Created on : Jan 22, 2012, 11:20:44 AM
    Author     : matthewschranz
--%>

<%@ page
  import="seneca.projectManagement.utils.CryptoUtil,
    seneca.projectManagement.databaseClasses.Accounts,
    java.sql.SQLException,
    seneca.projectManagement.persistence.PersistenceController"
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
    <h1>When the submit button is hit a new user will attempted to be added to the database with the data Chris, De Cairos, cdecairos@learn.senecac.on.ca, PRJ566SUM2012, TL and puppies (hashed before it's placed on the DB)</h1>
    
    <form method="post" action="../adserv">
      <input type="submit" value="Submit"/>
      <input type="hidden" name="testPage" value="true"/>
    </form>
  </body>
</html>
