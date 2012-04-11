<%-- 
    Document   : ManageAccounts
    Created on : Mar 5, 2012, 8:32:59 PM
    Author     : KepneR
--%>

<%@page import="java.util.Collections"%>
<%@page import="seneca.projectManagement.utils.AccountSorting"%>
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
  </head>
  <body>
    <table> 
      <tr>
        <td width="355px" style="background-image: url('../resources/images/header_left.jpg'); background-repeat: no-repeat;">&nbsp;</td>
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
              out.print("Hello Administrator, " + temp_a.getUserFName() + " " + temp_a.getUserLName());
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
            <li><a href="/PRJ666-Implementation/pages/Admin/HomeAdmin.jsp">Admin Home</a></li>
            <li><a href="/PRJ666-Implementation/pages/Admin/PendingComments.jsp">Pending Comments</a></li>
            <li><a href="/PRJ666-Implementation/pages/Admin/AvailableProjects.jsp">Available Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Admin/ProjectUpdate.jsp">Change Project Status to Past</a></li>
            <li><a href="/PRJ666-Implementation/pages/Admin/ManageAccounts.jsp">Manage Site Accounts</a></li>
          </ul>
          <div style="float: right;">
            <ul>
              <li><a href="/PRJ666-Implementation/pages/logout.jsp">Logout</a></li>
            </ul>
          </div>
        </td>
      </tr>
      <tr>
        <td>
          <h1>Account Management</h1>
          <form method="POST" action="UpdateAccounts.jsp">
          <%
            Integer beg = 0;
            Integer items = 10;
            Integer color = 0;
            Accounts a = null;
            List<Accounts> accts = userBean.getAllAccounts();
            if(accts.size() > 0) {
                Collections.sort(accts, new AccountSorting());
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
                out.println("<div style='width: 930px;'>");
                out.println("<div style='float: left; padding: 2px; width: 30px; text-align: center'>&nbsp;</div>");
                out.println("<div style='float: left; padding: 2px; width: 250px'>Username</div>");
                out.println("<div style='float: left; padding: 2px; width: 150px'>First Name</div>");
                out.println("<div style='float: left; padding: 2px; width: 150px'>Last Name</div>");
                out.println("<div style='float: left; padding: 2px; width: 100px'>Email</div>");
                out.println("<div style='float: left; padding: 2px; width: 100px'>Role</div>");
                out.println("<div style='float: left; padding: 2px; width: 60px'>Status</div>");
                out.println("<div style='clear: both'></div>");
                for(int i = beg; i < beg + items && i < accts.size(); i++) {
                    a = accts.get(i);
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
                            out.println("<input type='radio' name='accounts' value=" + a.getUserIdentifier() + " />");
                        out.println("</div>");
                        out.println("<div style='float: left; padding: 1px; width: 250px'>" + a.getUserIdentifier() + "</div>");
                        out.println("<div style='float: left; padding: 1px; width: 150px'>" + a.getUserFName() + "</div>");
                        out.println("<div style='float: left; padding: 1px; width: 150px'>" + a.getUserLName() + "</div>");
                        out.println("<div style='float: left; padding: 2px; width: 100px'><a href='mailto:" + a.getUserEmail() + "'>Email</a></div>");
                        out.println("<div style='float: left; padding: 2px; width: 100px'>" + a.getUserRole() + "</div>");
                        String s = a.getAccountStatus() == 1 ? "Active" : "Inactive";
                        out.println("<div style='float: left; padding: 2px; width: 60px'>" + s + "</div>");
                        out.println("<div style='clear: both'></div>");
                    out.println("</div>");
                }
                out.println("<div style='float: left'><input type='submit' value='Create New Account' name='create' /></div>");
                out.println("<div style='float: left'><input type='submit' value='Edit Selected Account' name='edit' /></div>");
                //out.println("<div style='float: left'><input type='submit' value='Remove Selected Account' name='remove' /></div>");
                out.println("<div style='float: right'>");
                int pages = (int) Math.ceil( (double) accts.size() / items);
                out.println(" Page(s): ");
                for(int i = 0; i < pages; i++) {
                    out.println("<a href='ManageAccounts.jsp?beg=" + i + "&items=" + items + "'>"+ (i + 1) + "</a> | ");
                }
                out.println("<a href='ManageAccounts.jsp?items=" + accts.size() + "'>View All</a>");
                out.println("</div>");
                out.println("<div style='clear: both'></div>");
                if(session.getAttribute("Error") != null) {
                    out.println("<span style='color: red'>" + session.getAttribute("Error") + "</span>");
                    session.removeAttribute("Error");
                }
                out.println("</div>");
            } else {
                out.println("No accounts to display!");
            }
          %>
          </form>
        </td>
      </tr>             
    </table>
  </body>
</html>
