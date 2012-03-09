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
    <script type="text/javascript" src="../resources/js/pageStuff.js"></script>
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
            <li><a href="/PRJ666-Implementation/pages/Team/teamHome.jsp">Team Home</a></li>
			      <li><a href="/PRJ666-Implementation/pages/Team/rankProjects.jsp">Rank Projects</a></li>
		        <li><a href="/PRJ666-Implementation/pages/Team/editTeamPage.jsp">Manage Team Page</a></li>
            <li><a href="/PRJ666-Implementation/pages/Team/createMilestone.jsp">Create Project Milestone</a></li>
            <li><a href="/PRJ666-Implementation/pages/Team/editMilestone.jsp">Edit Project Milestones</a></li>
            <li><a href="/PRJ666-Implementation/pages/Team/viewProjects.jsp">View Projects</a></li>
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
          <form method="POST" action="/PRJ666-Implementation/pages/validation/processTeam.jsp">
            <div style="width: 700px; background-color: #D5E7E9; padding: 5px;">
              Team Information 
            </div>
            <div style="width: 700px; padding: 5px">
              <div style="float: left; width: 150px">Team Name:</div>
              <div style="float: left"><input type="text" name="id_tName" value="<%= team.getTeamName() %>" /></div>
              <div style="float: left; color: red;">
              <%
                if(session.getAttribute("tName") != null) {
                  out.println("* " + session.getAttribute("tName").toString());
                  session.removeAttribute("tName");              
                }
              %>
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Team Description:</div>
              <div style="float: left">
                <textarea name="id_tDesc" cols="40" rows="10"><%= team.getTeamDescription() %></textarea>
              </div>
              <div style="float: left; color: red;">
              <%
                if(session.getAttribute("tDesc") != null) {
                  out.println("* " + session.getAttribute("tDesc").toString());
                  session.removeAttribute("tDesc");              
                }
              %>
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Team Constraints:</div>
              <div style="float: left">
                <textarea name="id_tCons" cols="40" rows="5"><%= team.getTeamConstraints() %></textarea>
              </div>
              <div style="float: left; color: red;">
              <%
                if(session.getAttribute("tCons") != null) {
                  out.println("* " + session.getAttribute("tCons").toString());
                  session.removeAttribute("tCons");              
                }
              %>
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Team Logo:</div>
              <div style="float: left"><input type="text" name="id_tLogo" value="<%= team.getTeamLogo() %>" /></div>
              <div style="float: left; color: red;">
              <%
                if(session.getAttribute("tLogo") != null) {
                  out.println("* " + session.getAttribute("tLogo").toString());
                  session.removeAttribute("tLogo");              
                }
              %>
              </div>
              <div style="clear: both"></div>
            </div>
            <div style="width: 700px; background-color: #D5E7E9; padding: 5px;">
              Team Leader 
            </div>
            <div style="width: 700px; padding: 5px">
              <div style="float: left; width: 150px">First Name:</div>
              <div style="float: left">
                <input type="text" name="id_tlFName" value="<%= leader.getFirstName() %>" /> 
              </div>
              <div style="float: left; color: red;">
              <%
                if(session.getAttribute("tlFName") != null) {
                  out.println("* " + session.getAttribute("tlFName").toString());
                  session.removeAttribute("tlFName");              
                }
              %>
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Last Name:</div>
              <div style="float: left">
                <input type="text" name="id_tlLName" value="<%= leader.getLastName() %>" /> 
              </div>
              <div style="float: left; color: red;">
              <%
                if(session.getAttribute("tlLName") != null) {
                  out.println("* " + session.getAttribute("tlLName").toString());
                  session.removeAttribute("tlLName");              
                }
              %>
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Email:</div>
              <div style="float: left">
                <input type="text" name="id_tlEmail" value="<%= leader.getEmail() %>" /> 
              </div>
              <div style="float: left; color: red;">
              <%
                if(session.getAttribute("tlEmail") != null) {
                  out.println("* " + session.getAttribute("tlEmail").toString());
                  session.removeAttribute("tlEmail");              
                }
              %>
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Member Image:</div>
              <div style="float: left">
                <input type="text" name="id_tlImage" value="<%= leader.getMemberImage() %>" /> 
              </div>
              <div style="float: left; color: red;">
              <%
                if(session.getAttribute("tlImage") != null) {
                  out.println("* " + session.getAttribute("tlImage").toString());
                  session.removeAttribute("tlImage");              
                }
              %>
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Member Description:</div>
              <div style="float: left;">
                <textarea name="id_tlDesc" cols="40" rows="5"><%= leader.getDescription() %></textarea> 
              </div>
              <div style="float: left; color: red;">
              <%
                if(session.getAttribute("tlDesc") != null) {
                  out.println("* " + session.getAttribute("tlDesc").toString());
                  session.removeAttribute("tlDesc");              
                }
              %>
              </div>
              <div style="clear: both"></div>
              </div>
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
              <div id="mem<%= i %>">
              <div style="width: 75%; text-align: left; padding: 5px;">
                Member <%= ++i %>: <br/><hr/>
              </div>
              <div style="float: left; width: 150px">First Name:</div>
              <div style="float: left">
                <input type="text" name="id_tmFName" value="<%= member.getFirstName() %>" /> 
              </div>
              <div style="float: left; color: red;">
              <%
                if(session.getAttribute("tmFName" + i) != null) {
                  out.println("* " + session.getAttribute("tmFName" + i).toString());
                  session.removeAttribute("tmFName" + i);              
                }
              %>
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Last Name:</div>
              <div style="float: left">
                <input type="text" name="id_tmLName" value="<%= member.getLastName() %>" /> 
              </div>
              <div style="float: left; color: red;">
              <%
                if(session.getAttribute("tmLName" + i) != null) {
                  out.println("* " + session.getAttribute("tmLName" + i).toString());
                  session.removeAttribute("tmLName" + i);              
                }
              %>
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Email:</div>
              <div style="float: left">
                <input type="text" name="id_tmEmail" value="<%= member.getEmail() %>" /> 
              </div>
              <div style="float: left; color: red;">
              <%
                if(session.getAttribute("tmEmail" + i) != null) {
                  out.println("* " + session.getAttribute("tmEmail" + i).toString());
                  session.removeAttribute("tmEmail" + i);              
                }
              %>
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Member Image:</div>
              <div style="float: left">
                <input type="text" name="id_tmImage" value="<%= member.getMemberImage() %>" /> 
              </div>
              <div style="float: left; color: red;">
              <%
                if(session.getAttribute("tmImage" + i) != null) {
                  out.println("* " + session.getAttribute("tmImage" + i).toString());
                  session.removeAttribute("tmImage" + i);              
                }
              %>
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Member Description:</div>
              <div style="float: left">
                <textarea name="id_tmDesc" cols="40" rows="5"><%= member.getDescription() %></textarea> 
              </div>
              <div style="float: left; color: red;">
              <%
                if(session.getAttribute("tmDesc" + i) != null) {
                  out.println("* " + session.getAttribute("tmDesc" + i).toString());
                  session.removeAttribute("tmDesc" + i);              
                }
              %>
              </div>
              <div style="clear: both"></div>
              </div>
            <% } %>
            </div>
            <div style="float: left; color: red;">
              <%
                if(session.getAttribute("errors") != null) {
                  out.println("* " + session.getAttribute("errors").toString());
                  session.removeAttribute("errors");              
                }
              %>
            </div>
            <div style="width: 700px; background-color: #D5E7E9; padding: 5px; text-align: right">
              <input type="submit" value="Save Team Information">
            </div>
            <input type="hidden" name="editTeamPage" value="true" />
          </form>
        </td>
      </tr>
    </table>
  </body>
</html>
