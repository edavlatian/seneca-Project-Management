<%@page import="seneca.projectManagement.utils.CryptoUtil"%>
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
    
    if(session.getAttribute("Second") == null) {
        response.sendRedirect("ManageAccounts.jsp");
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
            <h1>Updated Accounts</h1>
            <%
                Accounts a = (Accounts) session.getAttribute("ModifyAccounts");
                
                boolean showNewPass = false;
                String fname = request.getParameter("id_fname");
                String lname = request.getParameter("id_lname");
                String email = request.getParameter("id_email");
                String role = request.getParameter("id_role");
                String status = request.getParameter("id_status");
                String sType = request.getParameter("sType");
                String pass = CryptoUtil.generateRandomPassword();
                
                a.setUserFName(fname);
                a.setUserLName(lname);
                a.setUserEmail(email);
                a.setUserRole(role);
                a.setAccountStatus(new Integer(status));
                
                if(sType.equals("Reset Password") == true){
                    a.setPasswordHashed(pass);
                    showNewPass = true;
                }
                
                /*
                out.println(a.getUserId() + " " + a.getUserIdentifier());
                out.println("<br/> " + fname);
                out.println("<br/> " + lname);
                out.println("<br/> " + email);
                out.println("<br/> " + role);
                out.println("<br/> " + status);
                */
                
                if(userBean.updateAccounts(a)) {
                    out.println("Account for " + fname + " " + lname + " has been updated successfully");
                    if(showNewPass == true) {
                        out.println("<div style='padding: 10px; background-color: skyblue;'>");
                        out.println("Username: <b>" + a.getUserIdentifier() + "</b><br/>");
                        out.println("Password: <b>" + pass + "</b></div>");
                        out.println("<div style='color: red'>IMPORTANT: Please write down or keep a backup of your account information.</div>");
                    }
                } else {
                    out.println("An unexpected error has occured while updating the account!");
                }
                
                session.removeAttribute("ModifyAccounts");
                session.removeAttribute("Second");
            %>
        </td>
      </tr>             
    </table>
  </body>
</html>
