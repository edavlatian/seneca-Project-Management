<%-- 
    Document   : rankProjects
    Created on : Mar 4, 2012, 10:05:52 AM
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
        else if(userBean.getTeam().getProjectId() >= 0){
          session.setAttribute("Error", "You already are matched to a project");
          response.sendRedirect("/PRJ666-Implementation/pages/Home.jsp");
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
    <title>PRJ566 - Rank Projects</title>
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
            if(session.getAttribute("rankSuccess") != null){
          %>
              <div style="float: left; color: green;">
                <%= session.getAttribute("rankSuccess").toString() %>
              </div>
              <br/>
          <%
              session.removeAttribute("rankSuccess");
            }
            else if(session.getAttribute("rankFail") != null) {
          %>
              <div style="float: left; color: red;">
                <%= session.getAttribute("rankFail").toString() %>
              </div>
              <br/>
          <%
              session.removeAttribute("rankFail");  
            } 
          %>
          <div style="width: 900px; background-color: #D5E7E9; padding: 5px;">
            <h3>Rank Available Projects</h3>
          </div>
          <form method="post" action="../validation/processTeam.jsp">
            <table style="width: 90%;" cellpadding="5">
              <tr>
                <th style="width: 20%">Project Name</th>
                <th style="width: 45%">Project Description</th>
                <th style="width: 30%">Project Constraints</th>
                <th style="width: 5%">Your Rank</th>
              </tr>
          <%
              List<Projects> projects = userBean.getAllProjects("AV");
              Teams t = userBean.getTeam();
              Projects p;
              
              if(!projects.isEmpty()){
                if(!t.getHasRanked()){
                  for(int i = 0, len = projects.size(); i < len; i++){
                    p = projects.get(i);
          %>
                    <tr>
                      <td><%= p.getPrjName() %></td>
                      <td><%= p.getDescription() %></td>
                      <td><%= p.getPrjConstraints() %></td>
                      <td>
                        <input type="text" name="pRank" value="" style="width: 40px;" /><br/>
                        <input type="hidden" name="pId" value="<%= p.getProjectId() %>" />
                      </td>
                    </tr>
           <%
                  }
                }
                else{
                  List<Teamprojectranking> rankings = userBean.getTeamProjectRankings(t.getTeamId());
                  Teamprojectranking tm;
                  for(int i = 0, len = projects.size(); i < len; i++){
                    p = projects.get(i);
                    tm = rankings.get(i);
           %>
                    <tr>
                      <td><%= p.getPrjName() %></td>
                      <td><%= p.getDescription() %></td>
                      <td><%= p.getPrjConstraints() %></td>
                      <td>
                        <input type="text" name="pRank" value="<%= tm.getRanking() %>" style="width: 40px;" /><br/>
                        <input type="hidden" name="pId" value="<%= p.getProjectId() %>" />
                      </td>
                    </tr>
           <%
                  }
                }
              }
           %>
            </table>
            <%
              if(session.getAttribute("rankFailed") != null){
            %>
                <div style="color: red;">
                  <%= session.getAttribute("rankFailed").toString() %>
                </div>
                <br/>
            <%
                session.removeAttribute("rankFailed");
              }
            %>
            <input type="hidden" name="teamRanking" value="true"/>
            <button>Save Rankings</button>
          </form>
        </td>
      </tr>
    </table>
  </body>
</html>
