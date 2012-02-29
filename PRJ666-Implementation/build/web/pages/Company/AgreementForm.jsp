<%-- 
    Document   : AgreementForm
    Created on : Feb 20, 2012, 1:28:48 PM
    Author     : KepneR
--%>

<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%
    if(userBean.getLoggedUser() != null) {
        response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="/PRJ666-Implementation/pages/resources/css/pageStuff.css" />
    <script type="text/javascript" src="/PRJ666-Implementation/pages/resources/js/twitter.js"></script>
    <title>PRJ566 - Home</title>
    <style type="text/css">
        input[type=text], textArea, input[type=password] {
            width: 300px;
        }
    </style>
  </head>
  <body>
    <table> 
      <tr>
        <td colspan="2">
          <table width="100%">
            <tr>
              <td width="402" style="background-image: url('/PRJ666-Implementation/pages/resources/images/header_left.jpg'); background-repeat: no-repeat;">&nbsp;</td>
              <td style="background-image: url('/PRJ666-Implementation/pages/resources/images/header_bg.jpg'); background-repeat: repeat;" width="800"><center><h2>WELCOME TO PRJ566<br/> Project Planning and Management</h2></center></td>
            </tr>
          </table>
        </td>
      </tr>
      <tr valign="top">
        <td rowspan="5" align="left" width="200"> 
          <img src="/PRJ666-Implementation/pages/resources/images/seneca_logo.gif" title="Seneca logo"/>
          <br/>
          <img src="/PRJ666-Implementation/pages/resources/images/ICT_Logo.png" title="ICT Logo"/>
          <br/>
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
        <td style="background-image: url('/PRJ666-Implementation/pages/resources/images/header_bg.jpg')">
          <ul>
          <% 
            if(userBean.isLogged()) {
              if(userBean.getLoggedUser().getUserRole().equals("CR")){
          %>
			      <li><a href="#">Current Semester Teams</a></li>
		        <li><a href="#">Create New Project</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ViewCompanyProjects.jsp">Your Projects</a></li>
            <li><a href="#">Upcoming Milestones</a></li>
            <li><a href="#">Edit Company Info</a></li>
          <%
              }
              else if(userBean.getLoggedUser().getUserRole().equals("TL")){
                if(userBean.getTeam().getHasRegistered() == 1){
          %>
            <li><a href="#">Rank Projects</a></li>
		        <li><a href="#">Manage Project Milestones</a></li>
            <li><a href="#">View Projects</a></li>
            <li><a href="#">Manage Team Page</a></li>
          <%
                }
                else {
                  response.sendRedirect("/PRJ666-Implementation/pages/Team/publishTeamPage.jsp");  
                }
              }
              else if(userBean.getLoggedUser().getUserRole().equals("IN")){
          %>
            <li><a href="#">Create Team Accounts</a></li>
            <li><a href="#">Deactivate Team Accounts</a></li>
		        <li><a href="#">Match Teams/Projects</a></li>
            <li><a href="#">Match Teams/Projects Manually</a></li>
		        <li><a href="#">Pending Projects</a></li>
            <li><a href="#">Approved Projects</a></li>
            <li><a href="#">Proceed Projects</a></li>
          <%
              }
              else if(userBean.getLoggedUser().getUserRole().equals("SU")){   
          %>
            <li><a href="#">Change Project Status to Past</a></li>
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
              <li><a href="/PRJ666-Implementation/pages/logout.jsp">Logout</a></li>
          <%
            }
            else {
          %>
              <li><a href="/PRJ666-Implementation/pages/login.jsp">Login</a></li>
              <li><a href="/PRJ666-Implementation/pages/register.jsp">Register</a></li>
              <li><a href="/PRJ666-Implementation/pages/Company/AgreementForm.jsp">Company Registration</a></li>
          <% } %>
            </ul>
          </div>
        </td>
      </tr>
      <tr>
        <td>
        <h1>Agreement Form</h1>
        <form method="POST" action="Agreed.jsp">
            <div style="width: 700px">
                <iframe width="700" height="300" src="Agreement.html"
                        style="border-style: inset;">
                </iframe><br/>
            </div>
            <div style="width: 700px; text-align: right">
                <input type="checkbox" name="id_agree" value="agree" /> Yes, I agree to the above.
                <input type="submit" value="Continue" />
            <div>
            <div style="width: 700px; color: red">
            <%
                if(session.getAttribute("AgreementError") != null) {
                    out.println(session.getAttribute("AgreementError"));
                    session.removeAttribute("AgreementError");
                    session.invalidate();
                }
            %>
            </div>
        </form>
        </td>
      </tr>          
    </table>
  </body>
</html>
