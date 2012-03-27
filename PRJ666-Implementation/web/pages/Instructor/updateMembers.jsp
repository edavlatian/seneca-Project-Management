<%-- 
    Document   : updateMembers
    Created on : Mar 19, 2012, 7:52:08 PM
    Author     : matthewschranz
--%>

<%@page import="seneca.projectManagement.entity.Teammember"%>
<%@page import="java.util.List"%>
<%@page import="seneca.projectManagement.entity.Teams"%>
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
    <title>Instructor</title>
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
            <li><a href="/PRJ666-Implementation/pages/Instructor/HomeInstructor.jsp">Instructor<br/>Home</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/CreateTeam.jsp">Create<br/>Team<br/>Accounts</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/matching.jsp">Match<br/>Teams<br/>Projects</a></li>
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
          <%
                /**************************************************************
                Create New Member
                **************************************************************/
                if(request.getParameter("createMember") != null || session.getAttribute("createMember") != null) {
                    out.println("<h1>Create New Member</h1>");
          %>
                    <form method="POST" action="../validation/processInstructor.jsp">
                      <div style="width: 900px">
                        <div style="padding: 5px; background-color: #D5E7E9">
                          Member Information
                        </div>
                        <div style="padding: 5px">
                          <div style="float: left; width: 150px">First Name: </div>
                          <div style="float: left"><input type="text" name="mFName" size="40" value="${param.mFName}"/></div>
                          <div style="clear: both"></div>
                          <div style="float: left; width: 150px">Last Name: </div>
                          <div style="float: left"><input type="text" name="mLName" size="40" value="${param.mLName}"/></div>
                          <div style="clear: both"></div>
                          <div style="float: left; width: 150px">Email: </div>
                          <div style="float: left"><input type="text" name="mEmail" size="40" value="${param.mEmail}"/></div>
                          <div style="clear: both"></div>
                          <div style="float: left; width: 150px">Team:</div>
                          <div style="float: left">
                            <select name="mTeam">
                              <option value="0" selected>Select a Team</option>
                              <%
                                Teams t = null;
                                List<Teams> tms = userBean.getUnMatchedTeams(1);
                                for(int i = 0, len = tms.size(); i < len; i++){
                                  t = tms.get(i);
                              %>
                              <option value="<%= t.getTeamId() %>"><%= t.getTeamName() %></option>
                              <%
                                }
                              %>
                            </select>
                          </div>
                          <div style="clear: both"></div>
                          <%
                              if(session.getAttribute("createMemberFail") != null){
                                out.println("<div style='float: left; color: red;'>");
                                out.println(session.getAttribute("createMemberFail").toString());
                                out.println("</div><div style='clear: both'></div>");
                                session.removeAttribute("createMemberFail");
                              }
                          %>
                        </div>
                        <div style="background-color: #D5E7E9; padding: 5px; text-align: right">
                          <input type="submit" name="createTeamMember" value="Create New Member">
                        </div>
                      </div>
                    </form>
           <%
                /**************************************************************
                Delete Member
                **************************************************************/
                } else if (request.getParameter("deleteMember") != null) {
                  String mId = request.getParameter("mId");
                  Teammember mbr = null;
                  
                  if(mId != null){
                    mbr = userBean.getMember(new Integer(request.getParameter("mId")));
                    
                    if(userBean.removeMember(mbr)){
                      session.removeAttribute("deleteMember");
                      session.setAttribute("memberSuccess", "Successfully deleted " + mbr.getFirstName() + " " + mbr.getLastName() + ".");
                      response.sendRedirect("../Instructor/manageTeamMembers.jsp");
                    }
                    else {
                      session.setAttribute("Error", "Member removal failed. Please try manually removing them.");
                      response.sendRedirect("../Instructor/manageTeamMembers.jsp");
                    }
                  } 
                  else {
                    session.setAttribute("Error", "Error. Must select a member to perform a delete.");
                    response.sendRedirect("../Instructor/manageTeamMembers.jsp");
                  }
                
                }
            %> 
        </td>
      </tr>             
    </table>
  </body>
</html>

