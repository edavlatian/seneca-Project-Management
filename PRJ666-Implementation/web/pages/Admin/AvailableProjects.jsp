<%-- 
    Document   : AvailableProjects
    Created on : Mar 9, 2012, 9:08:25 PM
    Author     : KepneR
--%>

<%@page import="seneca.projectManagement.utils.ProjectSorting"%>
<%@page import="java.util.Collections"%>
<%@page import="seneca.projectManagement.entity.*"%>
<%@page import="java.util.List"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<jsp:setProperty name="userBean" property="*" />
<%
    session.setAttribute("First", 1);
    if(userBean.isLogged() == true && userBean != null) {
        if(userBean.getLoggedUser().getUserRole().equals("AD") == false) {
            session.setAttribute("Error", "You don't have permission to access the administrator page.");
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
    <title>Administrator</title>
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
              <td width="402" style="background-image: url('../resources/images/header_left.jpg'); background-repeat: no-repeat;">&nbsp;</td>
              <td style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;" width="800">
                <a href="/PRJ666-Implementation/pages/Home.jsp" style="color: black;"><center><h2>WELCOME TO PRJ566<br/> Project Planning and Management</h2></center></a>
              </td>
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
              out.print("Hello Administrator, " + temp_a.getUserFName() + " " + temp_a.getUserLName());
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
			      <li><a href="PendingComments.jsp">Pending Comments</a></li>
		        <li><a href="AvailableProjects.jsp">Available Projects</a></li>
            <li><a href="ProjectUpdate.jsp">Change Project Status to Past</a></li>
            <li><a href="ManageAccounts.jsp">Manage Site Accounts</a></li>
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
          <h1>List of Available Projects</h1>
            <form name="form1" method="POST" action="ProjectDetails.jsp">
            <%
                Projects p = null;
                //List<Projects> projects = userBean.getAllProjects();
                List<Projects> projects = userBean.getAllProjects("AV");
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
                            out.println("<b>Project Description:</b> <br/>" + p.getDescription());
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
                        out.println("<a href='AvailableProjects.jsp?beg=" + i + "&items=" + items + "'>"+ (i + 1) + "</a> | ");
                    }
                    out.println("<a href='AvailableProjects.jsp?items=" + projects.size() + "'>View All</a>");
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
