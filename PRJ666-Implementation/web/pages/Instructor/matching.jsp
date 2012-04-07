<%-- 
    Document   : matching
    Created on : Mar 13, 2012, 8:44:31 PM
    Author     : matthewschranz
--%>

<%@page import="seneca.projectManagement.entity.Teammember"%>
<%@page import="java.util.Calendar"%>
<%@page import="seneca.projectManagement.entity.Teams"%>
<%@page import="java.util.List"%>
<%@page import="seneca.projectManagement.entity.Accounts"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<jsp:setProperty name="userBean" property="*" />
<%
    if(userBean.isLogged() == true && userBean != null) {
        if(userBean.getLoggedUser().getUserRole().equals("IN") == false) {
            session.setAttribute("Error", "You don't have permission to access the instructor page.");
            response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
        }
    }
    else {
        response.sendRedirect("/PRJ666-Implementation/pages/Home.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
    <title>Instructor - Matching</title>
    <script>
      function setTeam(x) {
        document.form1.Team.value = x;
        document.form1.submit();
      }
    </script>
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
        <td rowspan="5" align="left" width="200"> 
          <img src="../resources/images/seneca_logo.gif" title="Seneca logo"/>
          <br/>
          <img src="../resources/images/ICT_Logo.png" title="ICT Logo"/>
          <br/>
          <%
          if(userBean != null) {
            if(userBean.isLogged() == true) {
              Accounts temp_a = userBean.getLoggedUser();
              out.println("<hr width='95%' align='left'/>");
              out.print("Hello Instructor, " + temp_a.getUserFName() + " " + temp_a.getUserLName());
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
        <td style="background-image: url('../resources/images/header_bg.jpg'); height: 1px;">
          <ul>
            <li><a href="/PRJ666-Implementation/pages/Instructor/HomeInstructor.jsp">Instructor<br/>Home</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/CreateTeam.jsp">Create<br/>Team<br/>Accounts</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/PendingProjects.jsp">Pending<br/>Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/ApprovedProjects.jsp">Approved<br/>Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/updateProjects.jsp">Change<br/>Project<br/>Status</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/manageTeamMembers.jsp">Manage<br/>Team<br/>Members</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/postNews.jsp">Post<br/>News</a></li>
            <li><a href="../logout.jsp">Logout</a></li>
          </ul>
        </td>
      </tr>
      <tr>
        <td>
          <h3 class="title">Current Active Semester Teams</h3>
          <form name="form1" method="POST" action="../Instructor/matchTeam.jsp">
            <%
                Teams t = null;
                List<Teams> tms = userBean.getUnMatchedTeams();
                Teammember leader = null;
                if(tms.size() > 0) {
                    Integer beg = 0;
                    Integer items = 8;
                    try {
                        items = new Integer(request.getParameter("items"));
                    }
                    catch (Exception e) {}
                    try {
                        beg = new Integer(request.getParameter("beg")) * items;
                    }
                    catch (Exception e) {}
                    for(int i = beg; i < beg + items && i < tms.size() ; i++) {
                        t = tms.get(i);
                        if(userBean.getLeader(t.getTeamId()) != null){
                          leader = userBean.getLeader(t.getTeamId());
                        }
                        
                        out.print("<div style='font-weight: bold; color: white; background-color: #6F93C9; padding: 5px;'>");
                          out.println("<div style='float: left'>");
                            out.println(t.getTeamName());
                          out.print("</div>");
                          out.println("<div style='float: right'>");
                            out.println("<input type='button' value='Match This Team' onclick='setTeam(" + t.getTeamId() + ")' />");
                          out.print("</div>");
                          out.print("<div style='clear: both'></div>");
                        out.print("</div>");
                        out.println("<div style='background-color: skyblue; padding: 10px'>");
                          out.println("<div style='float: left; width: 150px'><b>Team Leader:</b></div>");
                          if(leader != null){
                            out.println("<div style='float: left; width: 750px'>" + leader.getFirstName() +
                                    " " + leader.getLastName() + "</div>");
                          }
                          else{
                            out.println("<div style='float: left; width: 750px'>No Leader Assigned. Contact Team Members.</div>");    
                          }
                          out.print("<div style='clear: both'></div>");
                        out.println("</div>");
                    }
            %>
            <div style="border-style: solid; border-color: #6F93C9"> </div>
            <%
                    out.println("<div style='float: left'><input type='hidden' name='Team' /></div>");
                    out.println("<div style='float: right'>");
                    int pages = (int) Math.ceil( (double) tms.size() / items);
                    out.println(" Page(s): ");
                    for(int i = 0; i < pages; i++) {
                        out.println("<a href='matching.jsp?beg=" + i + "&items=" + items + "'>"+ (i + 1) + "</a> | ");
                    }
                    out.println("<a href='matching.jsp?items=" + tms.size() + "'>View All</a>");
                    out.println("</div>");
                    out.print("<div style='clear: both'></div>");
                    if(session.getAttribute("Error") != null) {
                        out.println("<span style='color: red'>" + session.getAttribute("Error") + "</span>");
                        session.removeAttribute("Error");
                    }
                    else if(session.getAttribute("matchSuccess") != null){
                      out.println("<span style='color: green'>" + session.getAttribute("matchSuccess") + "</span>");
                      session.removeAttribute("matchSuccess");                 
                    }
                } else {
                    out.println("<h1>No projects to display.</h1>");
                }
            %>
            </form>
        </td>
      </tr>             
    </table>
  </body>
</html>
