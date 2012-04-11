<%-- 
    Document   : manageTeamMembers
    Created on : Mar 18, 2012, 8:04:02 PM
    Author     : matthewschranz
--%>
<%@page import="seneca.projectManagement.entity.*"%>
<%@page import="java.util.List"%>
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
    <title>Instructor - Manage Team Members</title>
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
            <li><a href="/PRJ666-Implementation/pages/Instructor/matching.jsp">Match<br/>Teams<br/>Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/PendingProjects.jsp">Pending<br/>Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/ApprovedProjects.jsp">Approved<br/>Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/updateProjects.jsp">Change<br/>Project<br/>Status</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/postNews.jsp">Post<br/>News</a></li>
            <li><a href="../logout.jsp">Logout</a></li>
          </ul>
        </td>
      </tr>
      <tr>
        <td>
          <h1>Manage Team Members</h1>
          <form action="../Instructor/updateMembers.jsp" method="post">
          <%
            Integer beg = 0;
            Integer items = 8;
            Integer color = 0;
            List<Teammember> members = userBean.getActiveRegisteredTeamMembers();
            Teammember m = null;
            Teams t = null;
            if(members.size() > 0) {
                try {
                    items = new Integer(request.getParameter("items"));
                }
                catch (Exception e) {}
                try {
                    beg = new Integer(request.getParameter("beg")) * items;
                }
                catch (Exception e) {}
                out.println("<div style='width: 730px;'>");
                out.println("<div style='float: left; padding: 2px; width: 30px; text-align: center'>&nbsp;</div>");
                out.println("<div style='float: left; padding: 2px; width: 250px'>Name</div>");
                out.println("<div style='float: left; padding: 2px; width: 250px'>Team</div>");
                out.println("<div style='float: left; padding: 2px; width: 150px'>Email</div>");
                out.println("<div style='clear: both'></div>");
                for(int i = beg; i < beg + items && i < members.size(); i++) {
                    m = members.get(i);
                    System.out.println(m.getTeamId());
                    t = userBean.getTeamById(m.getTeamId());
                    out.print("<div style='font-weight: bold; padding: 5px; color: white; background-color: ");
                    if(color == 0) {
                        out.print("#6F93C9");
                        color = 1;
                    } else {
                        out.print("skyblue");
                        color = 0;
                    }
                    out.println("'>");
                        out.println("<div style='float: left; padding: 1px; width: 30px; text-align: center'>");
                            out.println("<input type='radio' name='mId' value=" + m.getMemberId() + " />");
                        out.println("</div>");
                        out.println("<div style='float: left; padding: 1px; width: 250px'>" + m.getFirstName() + " " + m.getLastName() + "</div>");
                        out.println("<div style='float: left; padding: 1px; width: 250px'>" + t.getTeamName() + "</div>");
                        out.println("<div style='float: left; padding: 1px; width: 150px'><a href='mailto:" + m.getEmail() + "'>Email</a></div>");
                        out.println("<div style='clear: both'></div>");
                    out.println("</div>");
                }
                out.println("<div style='float: left'><input type='submit' value='Add New Member' name='createMember' /></div>");
                out.println("<div style='float: left'><input type='submit' value='Remove Team Member' name='deleteMember' /></div>");
                out.println("<div style='float: right'>");
                int pages = (int) Math.ceil( (double) members.size() / items);
                out.println(" Page(s): ");
                for(int i = 0; i < pages; i++) {
                    out.println("<a href='manageTeamMembers.jsp?beg=" + i + "&items=" + items + "'>"+ (i + 1) + "</a> | ");
                }
                out.println("<a href='manageTeamMembers.jsp?items=" + members.size() + "'>View All</a>");
                out.println("</div>");
                out.println("<div style='clear: both'></div>");
                out.println("</div>");
            } else {
                out.println("There are no active team members right now! =/");
            }
            if(session.getAttribute("memberError") != null) {
              out.println("<span style='color: red'>" + session.getAttribute("memberError") + "</span>");
              session.removeAttribute("memberError");
            }
            else if(session.getAttribute("memberSuccess") != null){
              out.println("<span style='color: green'>" + session.getAttribute("memberSuccess") + "</span>");
              session.removeAttribute("memberSuccess");                 
            }
          %>
          </form>
        </td>
      </tr>             
    </table>
  </body>
</html>
