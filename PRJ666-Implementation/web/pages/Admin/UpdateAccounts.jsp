<%@page import="java.util.List"%>
<%@page import="seneca.projectManagement.entity.*"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
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
    
    if(session.getAttribute("First") == null) {
        response.sendRedirect("ManageAccounts.jsp");
    } else {
        session.setAttribute("Second", 1);
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
    <script language="javascript">
        function validateFormEmail() {
            var ret = false;
            var rx = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            ret = rx.test(document.forms["form1"]["id_email"].value);
            
            if(ret == false) {
                document.getElementById('errorEmail').innerHTML = "Invalid email address!";
            }
            return ret;
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
            <li><a href="/PRJ666-Implementation/pages/Admin/HomeAdmin.jsp">Admin Home</a></li>
            <li><a href="/PRJ666-Implementation/pages/Admin/PendingComments.jsp">Pending Comments</a></li>
            <li><a href="/PRJ666-Implementation/pages/Admin/AvailableProjects.jsp">Available Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Admin/ProjectUpdate.jsp">Change Project Status to Past</a></li>
            <li><a href="/PRJ666-Implementation/pages/Admin/ManageAccounts.jsp">Manage Site Accounts</a></li>
          </ul>
          <div style="float: right;">
            <ul>
              <li><a href="PRJ666-Implementation/pages/logout.jsp">Logout</a></li>
            </ul>
          </div>
        </td>
      </tr>
      <tr>
        <td>
            <%
                Accounts a = null;
                String s = request.getParameter("accounts");
                /**************************************************************
                Create new account
                **************************************************************/
                if(request.getParameter("create") != null) {
                    response.sendRedirect("CreateAccounts.jsp");
                /**************************************************************
                Edit account
                **************************************************************/
                } else if (request.getParameter("edit") != null) {
                    out.println("<h1>Edit Account</h1>");
                    if(s != null) {
                        a = userBean.getAccount(s);
                        session.setAttribute("ModifyAccounts", a);
                        %>
                        <form name="form1" method="POST" action="EditAccounts.jsp" onsubmit="return validateFormEmail()">
                            <div style="width: 900px">
                                <div style="padding: 5px; background-color: #D5E7E9">
                                    Account Information
                                </div>
                                <div style="padding: 5px">
                                    <div style="float: left; width: 150px">Username:</div>
                                    <div style="float: left"><%= a.getUserIdentifier() %></div>
                                    <div style="clear: both"></div>
                                    <div style="float: left; width: 150px">Password:</div>
                                    <div style="float: left"><input type="submit" value="Reset Password" name="sType" /></div>
                                    <div style="clear: both"><br/></div>
                                    <div style="float: left; width: 150px">First Name:</div>
                                    <div style="float: left"><input type="text" name="id_fname" value="<%= a.getUserFName() %>" /></div>
                                    <div style="clear: both"></div>
                                    <div style="float: left; width: 150px">Last Name:</div>
                                    <div style="float: left"><input type="text" name="id_lname" value="<%= a.getUserLName() %>" /></div>
                                    <div style="clear: both"></div>
                                    <div style="float: left; width: 150px">Email:</div>
                                    <div style="float: left">
                                        <input type="text" name="id_email" id="id_email" value="<%= a.getUserEmail() %>" />
                                        <span style="color: red" id="errorEmail"></span>
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
                                    <input type="submit" value="Modify" name="sType" />
                                </div>
                            </div>
                        </form>
                        <%
                    } else {
                        session.setAttribute("Error", "No account selected!");
                        response.sendRedirect("ManageAccounts.jsp");
                    }
                /**************************************************************
                Remove account
                **************************************************************/
                } else if (request.getParameter("remove") != null) {
                    out.println("<h1>Removed Account</h1>");
                    if(s != null) {
                        a = userBean.getAccount(s);
                        if (userBean.removeAccounts(a)) {
                            out.println(a.getUserFName() + " " + a.getUserLName() + " has been removed from the database.");
                        } else {
                            session.setAttribute("Error", "An unexpected error has occured while removing the account!");
                            response.sendRedirect("ManageAccounts.jsp");
                        }
                    } else {
                        session.setAttribute("Error", "No account selected!");
                        response.sendRedirect("ManageAccounts.jsp");
                    }
                } else {
                    response.sendRedirect("ManageAccounts.jsp");
                }
                session.removeAttribute("First");
            %>
        </td>
      </tr>             
    </table>
  </body>
</html>
