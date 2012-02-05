<%-- 
    Document   : publishTeamPage
    Created on : Feb 5, 2012, 11:44:45 AM
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
      <title>Publish Team Page</title>
      <script src="../resources/js/pageStuff.js" type="text/javascript"></script>
    </head>
    <body>
      <form method="post" action="../validation/processTeam.jsp">
        <table id="teamInfo"> 
          <tr>
            <td colspan="2" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;"><center><h2>Welcome to Team Page Registration Form</h2></center>       
          </td>
          </tr>
          <tr>
            <td colspan="2">*NOTE*: Please make sure you have all information needed before you Publish the Team Page.<br/>
            *NOTE*: Make sure you hit the Add Team Member button as needed before completing the form.
            </td>
          </tr>
          <tr>
            <td colspan="2" align="center" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;"><b>Team General Information</b></td>
          </tr> 
          <tr >
            <td>Enter team Name:</td>
            <td><input type="text" size="20" name="teamName" /></td>
          </tr>
          <tr>
            <td>Upload team logo: </td>
            <td><input type="file" name="teamLogo" size="40" /></td>
          </tr>
          <tr>
            <td>Short team description: </td>
            <td><textarea rows="3" cols="40" name="teamShortDescription"></textarea></td>
          </tr>
          <tr >
            <td>Enter team constraints:<br/><small> (e.g. availability for next term, technology limitations,<br /> programming language preferences, type of project)</small></td>
            <td><textarea rows="3" cols="40" name="teamConstraints"></textarea></td>
          </tr>
          <tr>
            <td colspan="2" align="center" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;"><b>Team Leader</b></td>
          </tr>
          <tr>
            <td><b>Team Leader Name: </b></td>
            <td><input type="text" size="30" name="teamLeaderName"/></td>
          </tr>
          <tr>
            <td>Upload your image: </td>
            <td><input type="file" name="teamLeaderImage" size="40"/></td>
          </tr>
          <tr>
            <td>Short story: </td>
            <td><textarea rows="3" cols="40" name="tlShortStory"></textarea></td>
          </tr>
          <tr>
            <td>E-mail address: </td>
            <td><input type='text' size='40' name="tlEmail"/></td>
          </tr>
          <tr>
            <td colspan="2" align="center" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;"><b>Team Members</b></td>
          </tr>
        </table>
        <input type="button" value="Add Team Member" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat; font-weight: bold;"
               onclick="addMember();"/>
        <br/>
        <input type="submit" value="Publish Team Page" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat; font-weight: bold;"
               name="publishTeam" />
               
      </form>
    </body>
  </html>
