<%-- 
    Document   : processOther
    Created on : Jan 26, 2012, 10:13:28 PM
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
