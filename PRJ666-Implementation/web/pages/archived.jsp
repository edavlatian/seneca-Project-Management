<%-- 
    Document   : archived
    Created on : Mar 12, 2012, 8:46:46 PM
    Author     : KepneR
--%>

<%@page import="seneca.projectManagement.utils.ProjectSorting"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%@page contentType="text/html" pageEncoding="UTF-8" import="seneca.projectManagement.entity.*"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="resources/css/pageStuff.css" />
        <script type="text/javascript" src="resources/js/twitter.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PRJ566 - Archived Projects</title>
        <script language="JavaScript">
            function setProject(x) {
                document.form1.Project.value = x;
                document.form1.submit();
            }
        </script>
    </head>
    <body>
    <table> 
      <tr>
        <td colspan="2">
          <table width="100%">
            <tr>
              <td width="402" style="background-image: url('resources/images/header_left.jpg'); background-repeat: no-repeat;">&nbsp;</td>
              <td style="background-image: url('resources/images/header_bg.jpg'); background-repeat: repeat;" width="800">
                <a href="/PRJ666-Implementation/pages/Home.jsp" style="color: black;"><center><h2>WELCOME TO PRJ566<br/> Project Planning and Management</h2></center></a>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr valign="top">
        <td rowspan="5" align="left" width="200"> 
          <img src="resources/images/seneca_logo.gif" title="Seneca logo"/>
          <br/>
          <img src="resources/images/ICT_Logo.png" title="ICT Logo"/>
          <br/>
          <%
          if(userBean != null) {
            if(userBean.isLogged() == true) {
              Accounts temp_a = userBean.getLoggedUser();
              out.println("<hr width='95%' align='left'/>");
              if(temp_a.getUserRole().equals("AD")) {
                out.print("Hello Administrator, " + temp_a.getUserFName() + " " + temp_a.getUserLName());
              } else if(temp_a.getUserRole().equals("CR")) {
                Company temp_c = userBean.getCompany();
                out.print("Hello, Company " + temp_c.getCompanyName());
              } else if(temp_a.getUserRole().equals("IN")) {
                out.print("Hello Instructor, " + temp_a.getUserFName() + " " + temp_a.getUserLName());
              } else if(temp_a.getUserRole().equals("SU")) {
                out.print("Hello Supervisor, " + temp_a.getUserFName() + " " + temp_a.getUserLName());
              } else if(temp_a.getUserRole().equals("TL")) {
                Teams temp_t = userBean.getTeam();
                out.print("Hello, Team " + temp_t.getTeamName());
              }
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
        <td style="background-image: url('resources/images/header_bg.jpg'); height: 1px;">
          <ul>
            <li><a href="Home.jsp">Home</a></li>
          <% 
            if(userBean.isLogged()) {
              if(userBean.getLoggedUser().getUserRole().equals("CR")){
          %>
            <li><a href="#">Current Semester Teams</a></li>
            <li><a href="#">Create New Project</a></li>
            <li><a href="Company/ViewCompanyProjects.jsp">Your Projects</a></li>
            <li><a href="#">Edit Company Info</a></li>
          <%
              }
              else if(userBean.getLoggedUser().getUserRole().equals("TL")){
                if(userBean.getTeam().getHasRegistered() == 1){
          %>
            <li><a href="/PRJ666-Implementation/pages/Team/teamHome.jsp">Team<br/>Home</a></li>
            <li><a href="/PRJ666-Implementation/pages/Team/manageTeamPage.jsp">Manage<br/>Team<br/>Page</a></li>
            <li><a href="/PRJ666-Implementation/pages/Team/viewProjects.jsp">View<br/>Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Team/teamProject.jsp">View<br/>Team<br/>Projects</a></li>
          <%
                }
                else {
                  response.sendRedirect("Team/publishTeamPage.jsp");  
                }
              }
              else if(userBean.getLoggedUser().getUserRole().equals("IN")){
          %>
            <li><a href="Instructor/InstructorHome.jsp">Instructor<br/>Home</a></li>
            <li><a href="Instructor/CreateTeam.jsp">Create<br/>Team<br/>Accounts</a></li>
            <li><a href="Instructor/matching.jsp">Match<br/>Teams<br/>Projects</a></li>
            <li><a href="Instructor/PendingProjects.jsp">Pending<br/>Projects</a></li>
            <li><a href="Instructor/ApprovedProjects.jsp">Approved<br/>Projects</a></li>
            <li><a href="Instructor/updateProjects.jsp">Change<br/>Project<br/>Status</a></li>
          <%
              }
              else if(userBean.getLoggedUser().getUserRole().equals("SU")){   
          %>
            <li><a href="Supervisor/ProjectUpdate.jsp">Change Project Status to Past</a></li>
            <li><a href="#">Current Semester Available Projects</a></li>
          <%
              }
              else if(userBean.getLoggedUser().getUserRole().equals("AD")){
		      %>
            <li><a href="#">Pending Comments</a></li>
            <li><a href="#">Available Projects</a></li>
            <li><a href="#">Change Project Status to Past</a></li>
            <li><a href="#">Manage Site Accounts</a></li>
          <%
              }
          %>
          </ul>
          <div style="float: right;">
            <ul>
              <li><a href="logout.jsp">Logout</a></li>
          <%
            }
            else {
          %>
              <li><a href="login.jsp">Login</a></li>
              <li><a href="archived.jsp">Archived Projects</a></li>
              <li><a href="Company/AgreementForm.jsp">Company<br/>Registration</a></li>
          <% } %>
            </ul>
          </div>
        </td>
      </tr>
      <tr>
        <td>
            <h1>List of Archived Projects</h1>
                <form name="form1" method="POST" action="ProjectDetails.jsp">
                <%
                    session.setAttribute("First", 1);
                    Projects p = null;
                    //List<Projects> projects = userBean.getAllProjects();
                    List<Projects> projects = userBean.getAllProjects("PA");
                    if(projects.size() > 0) {
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
                        for(int i = beg; i < beg + items && i < projects.size() ; i++) {
                            p = projects.get(i);
                            out.print("<div style='font-weight: bold; color: white; background-color: #6F93C9; padding: 5px;'>");
                                out.println("<div style='float: left'>");
                                    out.println(p.getPrjName());
                                out.print("</div>");
                                out.println("<div style='float: right'>");
                                    //out.println("Company: " + c.getCompanyName());
                                    out.println("<input type='button' value='View Project Details' onclick='setProject(" + p.getProjectId() + ")' />");
                                out.print("</div>");
                                out.print("<div style='clear: both'></div>");
                            out.print("</div>");
                            out.println("<div style='background-color: skyblue; padding: 10px'>");
                                out.println("<div style='float: left; width: 100px'><b>Description:</b></div>");
                                out.println("<div style='float: left; width: 800px'>" + p.getDescription() + "</div>");
                                out.print("<div style='clear: both'></div>");
                                out.println("<div style='float: left; width: 100px'><b>Constraints:</b></div>");
                                out.println("<div style='float: left; width: 800px'>" + p.getPrjConstraints() + "</div>");
                                out.print("<div style='clear: both'></div>");
                            out.println("</div>");
                        }
                %>
                <div style="border-style: solid; border-color: #6F93C9"> </div>
                <%
                        out.println("<div style='float: left'><input type='hidden' name='Project' /></div>");
                        out.println("<div style='float: right'>");
                        int pages = (int) Math.ceil( (double) projects.size() / items);
                        out.println(" Page(s): ");
                        for(int i = 0; i < pages; i++) {
                            out.println("<a href='archived.jsp?beg=" + i + "&items=" + items + "'>"+ (i + 1) + "</a> | ");
                        }
                        out.println("<a href='archived.jsp?items=" + projects.size() + "'>View All</a>");
                        out.println("</div>");
                        out.print("<div style='clear: both'></div>");
                        if(session.getAttribute("Error") != null) {
                            out.println("<span style='color: red'>" + session.getAttribute("Error") + "</span>");
                            session.removeAttribute("Error");
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

