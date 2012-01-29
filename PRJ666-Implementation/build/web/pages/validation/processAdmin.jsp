<%-- 
    Document   : processAdmin
    Created on : Jan 26, 2012, 8:26:25 PM
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
  
  <%
  if ("true".equals(request.getAttribute("testPage"))) {
    try {
      /* Obviously this needs real values
       */ 
      Accounts aAccount = new Accounts();
      aAccount.setUserfname("Chris");
      aAccount.setUserlname("De Cairos");
      aAccount.setUseremail("cdecairos@learn.senecac.on.ca");
      aAccount.setUseridentifier("PRJ566SUM2012");
      aAccount.setUserrole("TL");
      aAccount.setPassword("puppies");
        
      if(userBean.addAccount(aAccount)) {
        // redirect to admin home
      }
      else {
        // error handling code
      }
    } 
    catch (SQLException e) {
      e.getSQLState();
    }
    finally {
      out.close();
    }
  }
%>