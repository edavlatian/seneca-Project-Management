<%@page import="java.util.ArrayList"%>
<%@page import="seneca.projectManagement.utils.ProjectSorting"%>
<%@page import="java.util.Collections"%>
<%@page import="javax.validation.Validation"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.List"%>
<%@page import="seneca.projectManagement.entity.*"%>
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
            <li><a href="HomeAdmin.jsp">Administrator Home</a></li>
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
            <h1>List of Pending Comments</h1>
            <form method="POST" action="ApproveComments.jsp">
            <%
                Projects p = null;
                Integer count = 0;
                Integer beg = 0;
                Integer items = 5;
                List<Projects> prj = userBean.getAllProjects();
                List<Projects> prj2 = new ArrayList<Projects>();
                for(Projects temp : prj) {
                    List<Comments> temp1 = userBean.getAllComments(temp.getProjectId());
                    if(temp1.size() > 0) {
                        prj2.add(temp);
                    }
                }
                prj = prj2;
                if(prj.size() > 0) {
                    Collections.sort(prj, new ProjectSorting());
                    try {
                        items = new Integer(request.getParameter("items"));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    try {
                        beg = new Integer(request.getParameter("beg")) * items;
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    for(int i = beg; i < beg + items && i < prj.size(); i++) {
                        p = prj.get(i);
                        List<Comments> com = userBean.getAllComments(p.getProjectId());
                        if(com.size() > 0) {
                            out.print("<div style='font-weight: bold; color: white; background-color: #6F93C9; padding: 5px;'>");
                                out.println("<div style='float: left'>" + p.getPrjName() + "</div>");
                                out.println("<div style='float: right'>Status: " + p.getStatus() + "</div>");
                                out.println("<div style='clear: both'></div>");
                            out.print("</div>");
                            out.println("<div style='background-color: skyblue; padding: 10px'>");
                            count = 0;
                            out.println("<div><b>" + com.size() + " Pending Comment(s)</b></div>");
                            for(Comments c : com) {
                                out.println("<div style='border-top: 1px; border-top-style: solid; border-color: lightblue'></div>");
                                out.println("<div style='float: left'>");
                                out.print("<input type='checkbox' name='comments' value=" + c.getCommentId() + " />");
                                out.println("</div>");
                                out.println("<div style='width: 900px; float: left'>");
                                out.println(c.getCommentDescription());
                                out.println("</div>");
                                out.println("<div style='clear: both'></div>");
                            }
                            out.print("</div>");
                        }
                    }
                    out.println("<div style='border-style: solid; border-color: #6F93C9'></div>");
                    out.println("<div style='float: left'><input type='submit' value='Approve Comments' /></div>");
                    out.println("<div style='float: right'>");
                    int pages = (int) Math.ceil( (double) prj.size() / items);
                    out.println(" Page(s): ");
                    for(int i = 0; i < pages; i++) {
                        out.println("<a href='PendingComments.jsp?beg=" + i + "&items=" + items + "'>"+ (i + 1) + "</a> | ");
                    }
                    out.println("<a href='PendingComments.jsp?items=" + prj.size() + "'>View All</a>");
                    out.print("</div>");
                    out.println("<div style='clear: both'></div>");
                    if(session.getAttribute("Error") != null) {
                        out.println("<span style='color: red'>" + session.getAttribute("Error") + "</span>");
                        session.removeAttribute("Error");
                    }
                } else {
                    out.println("<h1>No comments to display.</h1>");
                }
            %>
            </form>
        </td>
      </tr>             
    </table>
  </body>
</html>
