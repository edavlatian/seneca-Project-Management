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
    if(userBean.isLogged() == true && userBean != null) {
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
        <td width="355px"style="background-image: url('../resources/images/header_left.jpg'); background-repeat: no-repeat;">&nbsp;</td>
        <td width="900px" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;">
          <a href="/PRJ666-Implementation/pages/Home.jsp" style="color: black;"><center><h2>WELCOME TO PRJ566<br/> Project Planning and Management</h2></center></a>
        </td>
      </tr>
      <tr valign="top">
        <td rowspan="50" align="left" width="200"> 
          <img src="../resources/images/seneca_logo.gif" title="Seneca logo"/>
          <br/>
          <img src="../resources/images/ICT_Logo.png" title="ICT Logo"/>
          <br/>
          <%
          if(userBean != null) {
            if(userBean.isLogged() == true) {
              Accounts temp_a = userBean.getLoggedUser();
              out.println("<hr width='95%' align='left'/>");
              Teams temp_t = userBean.getTeam();
              out.print("Hello, Team " + temp_t.getTeamName());
              out.println("<hr width='95%' align='left'/>");
            }
          }
          %>
          <div style="margin:2px; width:350px;">
            <script type="text/javascript"> 
		          new TWTR.Widget( {
  		          version: 2,
  		          type: "profile",
  		          rpp: 5,
 		            interval: 6000,
  		          width: 350,
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
          *NOTE*: Please make sure you have all information needed before you Publish the Team Page.
        </td>
      </tr>
      <tr>
        <td align="center" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;
            font-weight: bold;">
          Team General Information</td>
      </tr>
      <%
        if(session.getAttribute("countFail") != null){
          out.println("<tr><td style='color: red;'>");
          out.println(session.getAttribute("countFail").toString());
          out.println("</td></tr>");
          session.removeAttribute("countFail");
        }
      %>
      <tr>
        <td>
          <form method="post" action="../validation/processTeam.jsp">
          <table style="width: 100%;" >
            <tr>
              <td>Enter Team Name:</td>
              <td><input type="text" size="20" name="tName" value="<%= request.getParameter("tName") != null ? request.getParameter("tName") : ""  %>" /></td>
            </tr>
            <tr>
              <td>Team Logo Location:</td>
              <td><input type="text" name="tLogo" value="<%= request.getParameter("tLogo") != null ? request.getParameter("tLogo") : ""  %>"/></td>
            </tr>
            <tr>
              <td valign="top">Team Description:</td>
              <td><textarea rows="10" cols="50" name="tDesc"><%= request.getParameter("tDesc") != null ? request.getParameter("tDesc") : ""  %></textarea></td>
            </tr>
            <tr>
              <td valign="top">Enter Team Constraints:<br/><small> (e.g. availability for next term, technology limitations,<br /> programming language preferences, type of project)</small></td>
              <td><textarea rows="10" cols="50" name="tCons"><%= request.getParameter("tCons") != null ? request.getParameter("tCons") : ""  %></textarea></td>
            </tr>
            <%
              if(session.getAttribute("teamInfoFail") != null){
                out.println("<tr><td colspan=2 style='color: red;'>");
                out.println(session.getAttribute("teamInfoFail").toString());
                out.println("</td></tr>");
                session.removeAttribute("teamInfoFail");
              }
            %>
            <tr>
              <td colspan="2" align="center" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;"><b>Team Leader</b></td>
            </tr>
            <tr>
              <td>Team Leader First Name:</td>
              <td><input type="text" size="30" name="tlFName" value="<%= request.getParameter("tlFName") != null ? request.getParameter("tlFName") : ""  %>"/></td>
            </tr>
            <tr>
              <td>Team Leader Last Name:</td>
              <td><input type="text" size="30" name="tlLName" value="<%= request.getParameter("tlLName") != null ? request.getParameter("tlLName") : ""  %>"/></td>
            </tr>
            <tr>
              <td>Enter Image Location:</td>
              <td><input type="text" name="tlImage" value="<%= request.getParameter("tlImage") != null ? request.getParameter("tlImage") : ""  %>"/></td>
            </tr>
            <tr>
              <td>E-mail Address:</td>
              <td><input type='text' size='40' name="tlEmail" value="<%= request.getParameter("tlEmail") != null ? request.getParameter("tlEmail") : ""  %>"/></td>
            </tr>
            <tr>
              <td valign="top">Leader Description:</td>
              <td><textarea rows="10" cols="50" name="tlDesc" ><%= request.getParameter("tlDesc") != null ? request.getParameter("tlDesc") : ""  %></textarea></td>
            </tr>
            <%
              if(session.getAttribute("leaderInfoFail") != null){
                out.println("<tr><td colspan=2 style='color: red;'>");
                out.println(session.getAttribute("leaderInfoFail").toString());
                out.println("</td></tr>");
                session.removeAttribute("leaderInfoFail");
              }
            %>
            <tr>
              <td colspan="2" align="center" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;"><b>Team Member 1</b></td>
            </tr>
            <tr>
              <td>First Name:</td>
              <td><input type="text" size="30" name="tmFName" 
                       value="<%= request.getParameterValues("tmFName") != null ? request.getParameterValues("tmFName")[0] : ""  %>"/>
              </td>
            </tr>
            <tr>
              <td>Last Name:</td>
              <td><input type="text" size="30" name="tmLName" 
                         value="<%= request.getParameterValues("tmLName") != null ? request.getParameterValues("tmLName")[0] : ""  %>"/>
              </td>
            </tr>
            <tr>
              <td>Enter Image Location:</td>
              <td><input type="text" name="tmImage" 
                         value="<%= request.getParameterValues("tmImage") != null ? request.getParameterValues("tmImage")[0] : ""  %>"/>
              </td>
            </tr>
            <tr>
              <td>E-mail Address:</td>
              <td><input type='text' size='40' name="tmEmail" 
                         value="<%= request.getParameterValues("tmEmail") != null ? request.getParameterValues("tmEmail")[0] : ""  %>"/>
              </td>
            </tr>
            <tr>
              <td valign="top">Description:</td>
              <td>
                <textarea rows="10" cols="50" name="tmDesc"><%= request.getParameterValues("tmDesc") != null ? request.getParameterValues("tmDesc")[0] : ""  %></textarea>
              </td>
            </tr>
            <%
              if(session.getAttribute("memberInfoFail0") != null){
                out.println("<tr><td colspan=2 style='color: red;'>");
                out.println(session.getAttribute("memberInfoFail0").toString());
                out.println("</td></tr>");
                session.removeAttribute("memberInfoFail0");
              }
            %>
            <tr>
              <td colspan="2" align="center" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;"><b>Team Member 2</b></td>
            </tr>
            <tr>
              <td>First Name:</td>
              <td><input type="text" size="30" name="tmFName" 
                       value="<%= request.getParameterValues("tmFName") != null ? request.getParameterValues("tmFName")[1] : ""  %>"/>
              </td>
            </tr>
            <tr>
              <td>Last Name:</td>
              <td><input type="text" size="30" name="tmLName" 
                         value="<%= request.getParameterValues("tmLName") != null ? request.getParameterValues("tmLName")[1] : ""  %>"/>
              </td>
            </tr>
            <tr>
              <td>Enter Image Location:</td>
              <td><input type="text" name="tmImage" 
                         value="<%= request.getParameterValues("tmImage") != null ? request.getParameterValues("tmImage")[1] : ""  %>"/>
              </td>
            </tr>
            <tr>
              <td>E-mail Address:</td>
              <td><input type='text' size='40' name="tmEmail" 
                         value="<%= request.getParameterValues("tmEmail") != null ? request.getParameterValues("tmEmail")[1] : ""  %>"/>
              </td>
            </tr>
            <tr>
              <td valign="top">Description:</td>
              <td>
                <textarea rows="10" cols="50" name="tmDesc"><%= request.getParameterValues("tmDesc") != null ? request.getParameterValues("tmDesc")[1] : ""  %></textarea>
              </td>
            </tr>
            <%
              if(session.getAttribute("memberInfoFail1") != null){
                out.println("<tr><td colspan=2 style='color: red;'>");
                out.println(session.getAttribute("memberInfoFail1").toString());
                out.println("</td></tr>");
                session.removeAttribute("memberInfoFail1");
              }
            %>
            <tr>
              <td colspan="2" align="center" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;"><b>Team Member 3</b></td>
            </tr>
            <tr>
              <td>First Name:</td>
              <td><input type="text" size="30" name="tmFName" 
                       value="<%= request.getParameterValues("tmFName") != null ? request.getParameterValues("tmFName")[2] : ""  %>"/>
              </td>
            </tr>
            <tr>
              <td>Last Name:</td>
              <td><input type="text" size="30" name="tmLName" 
                         value="<%= request.getParameterValues("tmLName") != null ? request.getParameterValues("tmLName")[2] : ""  %>"/>
              </td>
            </tr>
            <tr>
              <td>Enter Image Location:</td>
              <td><input type="text" name="tmImage" 
                         value="<%= request.getParameterValues("tmImage") != null ? request.getParameterValues("tmImage")[2] : ""  %>"/>
              </td>
            </tr>
            <tr>
              <td>E-mail Address:</td>
              <td><input type='text' size='40' name="tmEmail" 
                         value="<%= request.getParameterValues("tmEmail") != null ? request.getParameterValues("tmEmail")[2] : ""  %>"/>
              </td>
            </tr>
            <tr>
              <td valign="top">Description:</td>
              <td>
                <textarea rows="10" cols="50" name="tmDesc"><%= request.getParameterValues("tmDesc") != null ? request.getParameterValues("tmDesc")[2] : ""  %></textarea>
              </td>
            </tr>
            <%
              if(session.getAttribute("memberInfoFail2") != null){
                out.println("<tr><td colspan=2 style='color: red;'>");
                out.println(session.getAttribute("memberInfoFail2").toString());
                out.println("</td></tr>");
                session.removeAttribute("memberInfoFail2");
              }
            %>
          </table>
          <button>Publish Team Page</button>
          <input type="hidden" name="publishTeamPage" value="true"/>
          </form> 
        </td>
      </tr>
    </table>
  </body>
</html>
