<%-- 
    Document   : ViewTeams
    Created on : Mar 13, 2012, 4:48:15 PM
    Author     : Edouard
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
%><%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
    <title>Instructor - Team List</title>
        <script language="JavaScript">
            function collapse(x, y) {
                if(x.value == "Collapse") {
                    document.getElementById(y).style.display = "none";
                    x.value = "Expand";
                } else {
                    document.getElementById(y).style.display = "block";
                    x.value = "Collapse";
                }
            }
        </script>    
  </head>
  <body>
    <table> 
      <tr>
        <td colspan="2">
          <table width="100%">
            <tr>
              <td width="402" style="background-image: url('../resources/images/header_left.jpg'); background-repeat: no-repeat;"></td>
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
            <li><a href="CreateTeam.jsp">Create<br/>Team<br/>Accounts</a></li>
            <li><a href="matching.jsp">Match<br/>Teams<br/>Projects</a></li>
            <li><a href="PendingProjects.jsp">Pending<br/>Projects</a></li>
            <li><a href="ApprovedProjects.jsp">Approved<br/>Projects</a></li>
            <li><a href="updateProjects.jsp">Change<br/>Project<br/>Status</a></li>
            <li><a href="../logout.jsp">Logout</a></li>
          </ul>
        </td>
      </tr>
      <tr>
        <td>
          <h1>List of Teams</h1>
          <form name="form1">
              <% 
                List<Teams> teams = userBean.getAllTeams();
                Teams t = null;
                if( teams.size() > 0 ){
                    Integer beg = 0;
                    Integer items = 5;
                    try {
                        items = new Integer(request.getParameter("items"));
                    }
                    catch (Exception e) {
                        e.printStackTrace();
                    }
                    try {
                        beg = new Integer(request.getParameter("beg")) * items;
                    }
                    catch (Exception e) {
                        e.printStackTrace();
                    }
                    for(int i = beg; i < beg + items && i < teams.size() ; i++) {
                        t = teams.get(i);
                        %>
                        <div style='font-weight: bold; color: white; background-color: #6F93C9; padding: 5px;'>
                            <div style='float: left'><%=t.getTeamName()%></div>
                            <div style='float: right'><input type='button' value='Expand' name='btnTeams' onclick='collapse(this, "_<%=i%>" )'/></div>
                            <div style='clear: both'></div>
                        </div>
                        <div style='background-color: skyblue; padding: 10px; display:none' id='_<%=i%>'>
                            <b>Team Description:</b><br/><%=t.getTeamDescription()%><br/><br/>
                            <b>Team Constraints:</b><br/><%=t.getTeamConstraints()%><br/><br/>
                            <br /><a href=mailto:'<%=t.getTeamEmail()%>'>Send email</a><br/><br/>
                        </div>
                        <%
                    }
                        %>
                        <div style='float: left'><input type='hidden' name='Client' /></div>
                        <div style='float: right'>
                        <%
                        int pages = (int) Math.ceil( (double) teams.size() / items);
                        %> Page(s): <%
                        for(int i = 0; i < pages; i++) {
                            out.println("<a href='ViewTeams.jsp?beg=" + i + "&items=" + items + "'>"+ (i + 1) + "</a> | ");
                        }%>
                        <a href='ViewTeams.jsp?items=<%=teams.size()%>'>View All</a>
                        </div>
                        <div style='clear: both'></div>     
                        <%
                }else{
                    out.println("<p>There are currently no clients</p>");
                }              
              %>
          </form>
        </td>
      </tr>             
    </table>
  </body>
</html>                        
