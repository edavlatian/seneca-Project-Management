<%-- 
    Document   : manageMilestones
    Created on : Mar 3, 2012, 10:05:52 AM
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
          response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
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
    <link rel="stylesheet" type="text/css" href="../resources/css/ui-lightness/jquery-ui-1.8.18.custom.css"/>
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
    <script type="text/javascript" src="../resources/js/pageStuff.js"></script>
    <script type="text/javascript" src="../resources/js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="../resources/js/jquery-ui-1.8.18.custom.min.js"></script>
    <script>
      $(function() {
		    $( "#datepicker" ).datepicker();
	    }); 
    </script>
    <title>PRJ566 - Create Milestone</title>
  </head>
  <body>
    <%
      if(session.getAttribute("createSuccess") != null){
        request.removeAttribute("milestoneDescription");
        request.removeAttribute("milestoneName");
        request.removeAttribute("milestoneDate");
        request.removeAttribute("milestoneStatus");
      }
    %>
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
        <td style="background-image: url('../resources/images/header_bg.jpg'); height: 1px;">
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
          <%
            if(session.getAttribute("createSuccess") != null){
          %>
              <div style="float: left; color: green;">
                <%= session.getAttribute("createSuccess").toString() %>
              </div>
              <br/>
          <%
              session.removeAttribute("createSuccess");
            }
          %>
          <form action="../validation/processTeam.jsp" method="post">
            <div style="width: 500px; background-color: #D5E7E9; padding: 5px;">
              Create Milestone 
            </div>
            <div style="width: 700px; padding: 5px">
              <div style="float: left; width: 150px">Milestone Name: </div>
              <div style="float: left"><input type="text" name="milestoneName" value="${param.milestoneName}" size="40"/></div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Milestone Description: </div>
              <div style="float: left"><input type="text" name="milestoneDescription" value="${param.milestoneDescription}" size="40"/></div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Milestone Status: </div>
              <div style="float: left"> 
                <select name="milestoneStatus">
                  <option value="NS" selected="selected">Not Started</option>
                  <option value="IP">In Progress</option>
                </select>
              </div>
              <div style="clear: both"></div>
              <div style="float: left; width: 150px">Due Date: </div>
              <div style="float: left"><input type="text" id="datepicker" name="milestoneDate" value="${param.milestoneDate}"/></div>
              <div style="clear: both"></div>
          <%
            if(session.getAttribute("createErrors") != null) {
          %>
              <div style="float: left; color: red;">
                <%= session.getAttribute("createErrors").toString() %>
              </div>
              <div style="clear: both"></div>
              <br/>
          <%
              session.removeAttribute("createErrors");
            }
          %>
            <button name="create">Create Milestone</button>
            <input type="hidden" name="createMilestone" value="true" />
          </form>  
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>
