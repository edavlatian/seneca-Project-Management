<%@page import="seneca.projectManagement.utils.CryptoUtil"%>
<%@page import="java.util.Collections"%>
<%@page import="seneca.projectManagement.utils.AccountSorting"%>
<%@page import="seneca.projectManagement.entity.*"%>
<%@page import="java.util.List"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<jsp:setProperty name="userBean" property="*" />
<%
    if(userBean.isLogged() == true && userBean != null) {
        if(userBean.getLoggedUser().getUserRole().equals("AD") == false) {
            session.setAttribute("Error", "You don't have permission to access the administrator page.");
            response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
        }
    }
    else {
        response.sendRedirect("/PRJ666-Implementation/pages/Home.jsp");
    }
    
    Accounts a = new Accounts();
    a.setUserIdentifier("");
    a.setUserFName("");
    a.setUserLName("");
    a.setUserEmail("");
    a.setUserRole("");
    a.setAccountStatus(0);
    if(session.getAttribute("Account") != null) {
        a = (Accounts) session.getAttribute("Account");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>  
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
    <title>Administrator</title>
    <style type="text/css">
        input[type=text], textArea, input[type=password] {
            width: 300px;
        }
    </style>
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
          <h1>Create Account</h1>
          <form method="POST" action="newAccounts.jsp">
            <div style="width: 900px">
            <div style="padding: 5px; background-color: #D5E7E9">
                Account Information
            </div>
            <div style="padding: 5px">
                <div style="float: left; width: 150px">User Name:</div>
                <div style="float: left">
                    <input type="text" name="id_user" value="<%= a.getUserIdentifier() %>" />
                    <% 
                        if(session.getAttribute("user") != null) {
                            out.println("<span style='color: red'>* " + session.getAttribute("user").toString() + "</span>");
                            session.removeAttribute("user");
                        }
                    %>
                </div>
                <div style="clear: both; height: 20px"></div>
                <div style="float: left; width: 150px">First Name:</div>
                <div style="float: left">
                    <input type="text" name="id_fname" value="<%= a.getUserFName() %>" />
                    <% 
                        if(session.getAttribute("fname") != null) {
                            out.println("<span style='color: red'>* " + session.getAttribute("fname").toString() + "</span>");
                            session.removeAttribute("fname");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Last Name:</div>
                <div style="float: left">
                    <input type="text" name="id_lname" value="<%= a.getUserLName() %>" />
                    <% 
                        if(session.getAttribute("lname") != null) {
                            out.println("<span style='color: red'>* " + session.getAttribute("lname").toString() + "</span>");
                            session.removeAttribute("lname");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Email:</div>
                <div style="float: left">
                    <input type="text" name="id_email" id="id_email" value="<%= a.getUserEmail() %>" />
                    <% 
                        if(session.getAttribute("email") != null) {
                            out.println("<span style='color: red'>* " + session.getAttribute("email").toString() + "</span>");
                            session.removeAttribute("email");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Role:</div>
                <div style="float: left">
                    <select name="id_role">
                        <option value="AD" <%= a.getUserRole().equals("AD") ? "selected" : "" %>>Administrator</option>
                        <option value="CR" <%= a.getUserRole().equals("CR") ? "selected" : "" %>>Company Representative</option>
                        <option value="IN" <%= a.getUserRole().equals("IN") ? "selected" : "" %>>Instructor</option>
                        <option value="SU" <%= a.getUserRole().equals("SU") ? "selected" : "" %>>Supervisor</option>
                        <option value="TL" <%= a.getUserRole().equals("TL") ? "selected" : "" %>>Team Leader</option>
                    </select>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Status:</div>
                <div style="float: left">
                    <select name="id_status">
                        <option value="1" <%= a.getAccountStatus() == 1 ? "selected" : "" %>>Active</option>
                        <option value="0" <%= a.getAccountStatus() == 0 ? "selected" : "" %>>Inactive</option>
                    </select>
                </div>
                <div style="clear: both"></div>
            </div>
            <div style="background-color: #D5E7E9; padding: 5px; text-align: right">
                <input type="submit" value="Create">
            </div>
        </div>
          </form>
        </td>
      </tr>             
    </table>
  </body>
</html>
