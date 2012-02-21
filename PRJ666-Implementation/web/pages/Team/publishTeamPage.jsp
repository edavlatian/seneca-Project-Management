<%-- 
    Document   : publishTeamPage
    Created on : Feb 1, 2012, 11:44:45 AM
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

  <!DOCTYPE html>
  <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <title>Publish Team Page</title>
      <script src="../resources/js/jquery-1.7.1.js" type="text/javascript"></script>
      <script src="../resources/js/pageStuff.js" type="text/javascript"></script>
      <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    </head>
    <body>
      <form method="post" action="../validation/processTeam.jsp" onsubmit="return validateTeamPublish()">
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
            <td>Enter Team Name:</td>
            <td><input type="text" size="20" name="teamName" onchange="validateTeamName( this )" value="${param.teamName}" /></td>
          </tr>
          <tr>
            <td>Upload Team Logo:</td>
            <td><input type="file" name="teamLogo" onchange="validateFileSize( this )" accept="image/*"/></td>
          </tr>
          <tr>
            <td>Team Description:</td>
            <td><textarea rows="3" cols="40" name="teamDescription" onchange="validateTeamDescription( this )" value="${param.teamDescription}"></textarea></td>
          </tr>
          <tr >
            <td>Enter Team Constraints:<br/><small> (e.g. availability for next term, technology limitations,<br /> programming language preferences, type of project)</small></td>
            <td><textarea rows="3" cols="40" name="teamConstraints" onchange="validateTeamConstraints( this )"
                          value="${param.teamConstraints}"></textarea></td>
          </tr>
          <tr>
            <td colspan="2" align="center" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;"><b>Team Leader</b></td>
          </tr>
          <tr>
            <td>Team Leader First Name:</td>
            <td><input type="text" size="30" name="tlFName" onchange="validateName( this )" value="${param.tlFName}"/></td>
          </tr>
          <tr>
            <td>Team Leader Last Name:</td>
            <td><input type="text" size="30" name="tlLName" onchange="validateName( this )" value="${param.tlLName}"/></td>
          </tr>
          <tr>
            <td>Upload Your Image:</td>
            <td><input type="file" name="tlImage" onchange="validateFileSize( this )" accept="image/*"/></td>
          </tr>
          <tr>
            <td>Leader Description:</td>
            <td><textarea rows="3" cols="40" name="tlDesc" onchange="validateMemberDescription( this )"
                          value="${param.tlDesc}"></textarea></td>
          </tr>
          <tr>
            <td>E-mail Address:</td>
            <td><input type='text' size='40' name="tlEmail" onchange="validateEmail( this )" value="${param.tlEmail}"/></td>
          </tr>
          <tr>
            <td colspan="2" align="center" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;"><b>Team Members</b></td>
          </tr>
        </table>
        <input type="button" value="Add Team Member" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat; font-weight: bold;"
               onclick="addMember();"/>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" value="Publish Team Page" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat; font-weight: bold;"
               name="publishTeam" />
        <br/>
        <div id="errors" style="color: red;">${param.errors}</div>
        <input type="hidden" name="publishTeamPage" value="true"/>
      </form>
    </body>
  </html>
