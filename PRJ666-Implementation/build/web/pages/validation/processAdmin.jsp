<%-- 
    Document   : processAdmin
    Created on : Jan 26, 2012, 8:26:25 PM
    Author     : matthewschranz
--%>
<%@ page
  import="seneca.projectManagement.utils.CryptoUtil,
    seneca.projectManagement.entity.*,
    java.sql.SQLException"
  language="java" contentType="text/html; charset=ISO-8859-1"
  pageEncoding="ISO-8859-1"%>
  
  <jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession"
               scope="session" />
  <jsp:setProperty name="userBean" property="*" />
  
  <%
  if ("true".equals("true")) {
    response.sendRedirect("../Admin/HomeAdmin.jsp");
  }
%>