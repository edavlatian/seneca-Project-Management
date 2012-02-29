<%-- 
    Document   : editTeamPage
    Created on : Feb 28, 2012, 10:05:52 AM
    Author     : matthewschranz
--%>

<%@page import="java.util.List"%>
<%@page import="seneca.projectManagement.entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
  <jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession"
               scope="session" />
  <jsp:setProperty name="userBean" property="*" />
<%
    if(userBean.isLogged() == true) {
        if(userBean.getLoggedUser().getUserRole().equals("TL")) {
          if(userBean.getTeam().getHasRegistered() != 1)
            response.sendRedirect("publishTeamPage.jsp");
        }
        else if(userBean.getLoggedUser().getAccountStatus() != 1) {
          session.setAttribute("Error", "Account has not been activated yet.");
          response.sendRedirect("../login.jsp");
        }
    }
    else {
        response.sendRedirect("../Home.jsp");
    }
%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
    <title>PRJ566 - Edit Team Page</title>
  </head>
  <%
    Integer teamId = userBean.getTeam().getTeamId();
    List<Teammember> teamMembers = userBean.getAllTeamMembers( teamId );
    Teammember leader = userBean.getLeader( teamId );
    Teams team = userBean.getTeam();
  %>
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
        <td rowspan="5" align="left" width="200"> 
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
          <ul>
            <li><a href="teamHome.jsp">Team Home</a></li>
			      <li><a href="#">Rank Projects</a></li>
		        <li><a href="editTeamPage.jsp">Manage Team Page</a></li>
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
        <td>
          <h1>Team Edit Page Form</h1>
          <form method="POST" action="">
            <div style="width: 700px; background-color: #D5E7E9; padding: 5px;">
              Team Information 
            </div>
            <div style="width: 700px; padding: 5px">
              <div style="float: left; width: 150px">Team Name:</div>
              <div style="float: left"><input type="text" name="tName" value="<%= team.getTeamName() %>" /></div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Team Description:</div>
              <div style="float: left">
                <textarea name="tDesc" cols="40" rows="10"><%= team.getTeamDescription() %></textarea>
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Team Constraints:</div>
              <div style="float: left">
                <textarea name="tCons" cols="40" rows="5"><%= team.getTeamConstraints() %></textarea>
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Team Logo:</div>
              <div style="float: left"><input type="text" name="tLogo" value="Debate Changing Logos to same as Files" /></div>
              <div style="clear: both"></div>
            </div>
            <div style="width: 700px; background-color: #D5E7E9; padding: 5px;">
              Team Members
            </div>
            <div style="width: 700px; padding: 5px">
              <%
                Teammember member;
                for ( int i = 0, len = teamMembers.size(); i < len; i++ ){
                  member = teamMembers.get( i );
              %>
              <div style="width: 75%; text-align: left; padding: 5px;">
                Member <%= ++i %>: <br/><hr/>
              </div>
              <div style="float: left; width: 150px">First Name:</div>
              <div style="float: left">
                <input type="text" name="tmFName" value="<%= member.getFirstName() %>" /> 
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Last Name:</div>
              <div style="float: left">
                <input type="text" name="tmLName" value="<%= member.getLastName() %>" /> 
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Email:</div>
              <div style="float: left">
                <input type="text" name="tmEmail" value="<%= member.getEmail() %>" /> 
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Member Image:</div>
              <div style="float: left">
                <input type="text" name="tmImage" value="<%= member.getMemberImage() %>" /> 
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Member Description:</div>
              <div style="float: left">
                <textarea name="tmDesc" cols="40" rows="5"><%= member.getDescription() %></textarea> 
              </div>
              <div style="clear: both"></div>
            <% } %>
            </div>
            <div style="width: 700px; background-color: #D5E7E9; padding: 5px; text-align: right">
              <input type="submit" value="Save Team Information">
            </div>
          </form>
          *NOTE* Unfinished.
        </td>
      </tr>
    </table>
  </body>
</html>
