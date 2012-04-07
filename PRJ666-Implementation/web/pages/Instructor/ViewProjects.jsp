<%-- 
    Document   : ViewProjects
    Created on : Mar 13, 2012, 4:36:05 PM
    Author     : Edouard
--%>
<%@page import="seneca.projectManagement.utils.ProjectSorting"%>
<%@page import="java.util.Collections"%>
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
    <title>Instructor - Project List</title>
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
            <li><a href="/PRJ666-Implementation/pages/Instructor/manageTeamMembers.jsp">Manage<br/>Team<br/>Members</a></li>
            <li><a href="/PRJ666-Implementation/pages/Instructor/postNews.jsp">Post<br/>News</a></li>
            <li><a href="../logout.jsp">Logout</a></li>
          </ul>
        </td>
      </tr>
      <tr>
        <td>
          <h1>List of Projects</h1>
          <form name="form1">
              <%
                session.setAttribute("First", 1);
                List<Projects> projects = userBean.getAllProjects();
                Projects p = null;
                if( projects.size() > 0 ){
                    Collections.sort(projects, new ProjectSorting());
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
                    for(int i = beg; i < beg + items && i < projects.size(); i++) {
                        p = projects.get(i);
                        Company c = userBean.getCompanyByID(p.getCompanyId());
                        
                        %>
                        <div style='font-weight: bold; color: white; background-color: #6F93C9; padding: 5px;'>
                            <div style='float: left'><%=p.getPrjName()%></div>
                            <div style='float: right'><input type='button' value='Expand' name='btnProject' onclick='collapse(this, "_<%=i%>" )'/></div>
                            <div style='clear: both'></div>
                        </div>
                        <div style='background-color: skyblue; padding: 10px; display:none' id='_<%=i%>'>
                            <b>Project Description:</b><br/><%=p.getDescription()%><br/><br/>
                            <b>Constraints:</b><br/><%=p.getPrjConstraints()%><br/><br/>
                            <b>Company:</b><br />
                            <%//A Project is missing a company, specifically the laboratory project.
                            if(c!=null){
                                out.println(c.getCompanyName());
                                out.println("<br/><br/><b>Representative: </b><br />");
                                Accounts a = userBean.getAccount(c.getUserId());
                                out.println(a.getUserFName() + " " +a.getUserLName() +"<br/>");
                                out.println("<a href=mailto:'" +a.getUserEmail()+ "'>Send email</a><br/>");
                            }else{
                                out.println("No Company");
                            }%>
                        </div>
                        <%
                    }
                        %>
                        <div style='float: left'><input type='hidden' name='Client' /></div>
                        <div style='float: right'>
                        <%
                        int pages = (int) Math.ceil( (double) projects.size() / items);
                        %> Page(s): <%
                        for(int i = 0; i < pages; i++) {
                            out.println("<a href='ViewProjects.jsp?beg=" + i + "&items=" + items + "'>"+ (i + 1) + "</a> | ");
                        }%>
                        <a href='ViewProjects.jsp?items=<%=projects.size()%>'>View All</a>
                        </div>
                        <div style='clear: both'></div>     
                        <%                    
                }else{
                    out.println("<p>There are currently no Projects</p>");
                }
              %>              
          </form>
        </td>
      </tr>             
    </table>
  </body>
</html>      