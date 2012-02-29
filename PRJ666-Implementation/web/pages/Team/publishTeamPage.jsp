<%-- 
    Document   : teamHome
    Created on : Feb 1, 2012, 10:05:52 AM
    Author     : matthewschranz
--%>

<%@page import="seneca.projectManagement.entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
  <jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession"
               scope="session" />
  <jsp:setProperty name="userBean" property="*" />
<%
    if(userBean.isLogged() == true) {
        if(userBean.getLoggedUser().getUserRole().equals("TL")){
          Teams team = userBean.getTeam();
          if(userBean.getLoggedUser().getAccountStatus() != 1) {
            session.setAttribute("Error", "Account has not been activated yet.");
            response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
          }
          else if( team.getHasRegistered() == 1 ){
            response.sendRedirect("teamHome.jsp");
          }
        }
    }
    else {
        response.sendRedirect("/PRJ666-Implementation/pages/Home.jsp");
    }
%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
    <script type="text/javascript" src="../resources/js/pageStuff.js"></script>
    <title>PRJ566 - Publish Team Page</title>
  </head>
  <body>
    <table> 
      <tr>
        <td colspan="2">
          <table width="100%">
            <tr>
              <td width="402" style="background-image: url('../resources/images/header_left.jpg'); background-repeat: no-repeat;">&nbsp;</td>
              <td style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;" width="800"><center><h2>WELCOME TO PRJ566<br/> Project Planning and Management</h2></center></td>
            </tr>
          </table>
        </td>
      </tr>
      <tr valign="top">
        <td rowspan="50" align="left" width="200"> 
          <img src="../resources/images/seneca_logo.gif" title="Seneca logo"/>
          <br/>
          <img src="../resources/images/ICT_Logo.png" title="ICT Logo"/>
          <br/>
          <div style="margin:2px; width:200px;">
            <script type="text/javascript"> 
		          new TWTR.Widget( {
  		          version: 2,
  		          type: "profile",
  		          rpp: 5,
 		            interval: 6000,
  		          width: "auto",
  		          height: 300,
  		          theme: {
    		          shell: {
      		          background: "#d5e7e9",
      		          color: "#000000"
    		          },
    		          tweets: {
      		          background: "#fffaff",
     		            color: "#000000",
      		          links: "#0772eb"
    		          }
  		          },	
  		          features: {
    		          scrollbar: false,
    		          loop: false,
    		          live: false,
    		          hashtags: true,
    		          timestamp: true,
    	    	      avatars: false,
    		          behavior: "all"
  		          }
		          } ).render().setUser( "Seneca_College" ).start();
		        </script>
		      </div>
        </td>
        <td style="background-image: url('../resources/images/header_bg.jpg')">
          <ul style="display: none;">
            <li><a href="teamHome.jsp">Team Home</a></li>
			      <li><a href="#">Rank Projects</a></li>
		        <li><a href="#">Manage Team Page</a></li>
            <li><a href="#">Manage Project Milestones</a></li>
            <li><a href="viewProjects.jsp">View Projects</a></li>
		      </ul>
          <div style="float: right;">
            <ul>
              <li><a href="../logout.jsp">Logout</a></li>
            </ul>
          </div>
        </td>
      </tr>
      <tr>
        <td style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;
            text-align: center;">
          <h2>Welcome to Team Page Publish Form</h2>       
          </td>
      </tr>
      <tr>
        <td>
          *NOTE*: Please make sure you have all information needed before you Publish the Team Page.<br/>
          *NOTE*: Make sure you hit the Add Team Member button as needed before completing the form.
        </td>
      </tr>
      <tr>
        <td align="center" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;
            font-weight: bold;">
          Team General Information</td>
      </tr>
      <tr>
        <td>
          <form method="post" action="../validation/processTeam.jsp" onsubmit="return validateTeamPublish()">
          <table id="teamInfo" >  
            <tr>
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
            <tr>
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
          <button style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat; font-weight: bold;">
            Publish Team Page
          </button> 
          <br/>
          <div id="errors" style="color: red;">${param.errors}</div>
          <input type="hidden" name="publishTeamPage" value="true"/>
          </form>
          <button style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat; font-weight: bold;"
                  onclick="addMember()">
            Add Team Member
          </button>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <button style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat; font-weight: bold;"
                  onclick="removeMember()">
            Remove Team Member
          </button> 
        </td>
      </tr>
    </table>
  </body>
</html>
