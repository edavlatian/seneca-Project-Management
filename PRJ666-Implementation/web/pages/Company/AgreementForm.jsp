<%-- 
    Document   : AgreementForm
    Created on : Feb 20, 2012, 1:28:48 PM
    Author     : KepneR
--%>

<%@page import="seneca.projectManagement.entity.Company"%>
<%@page import="seneca.projectManagement.entity.Accounts"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%
    if(userBean.getLoggedUser() != null && userBean != null) {
        response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="/PRJ666-Implementation/pages/resources/css/pageStuff.css" />
    <script type="text/javascript" src="/PRJ666-Implementation/pages/resources/js/twitter.js"></script>
    <title>PRJ566 - Agreement Form</title>
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
          <img src="/PRJ666-Implementation/pages/resources/images/seneca_logo.gif" title="Seneca logo"/>
          <br/>
          <img src="/PRJ666-Implementation/pages/resources/images/ICT_Logo.png" title="ICT Logo"/>
          <br/>
          <%
          if(userBean != null) {
            if(userBean.isLogged() == true) {
              Accounts temp_a = userBean.getLoggedUser();
              out.println("<hr width='95%' align='left'/>");
              Company temp_c = userBean.getCompany();
              out.print("Hello, Company " + temp_c.getCompanyName());
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
        <td style="background-image: url('/PRJ666-Implementation/pages/resources/images/header_bg.jpg')">
          <ul>
          <% 
            if(userBean.isLogged()) {
              if(userBean.getLoggedUser().getUserRole().equals("CR")){
          %>
            <li><a href="/PRJ666-Implementation/pages/Company/HomeCompany.jsp">Company Home</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ProjectAgreementForm.jsp">Create New Project</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ViewCompanyProjects.jsp">Your Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ManageCompanyInfo.jsp">Edit Company Info</a></li>
          <%
              }
            }
          %>
          </ul>    
          <div style="float: right;">
            <ul>
              <li><a href="/PRJ666-Implementation/pages/archived.jsp">Archived<br/>Projects</a></li>
              <li><a href="/PRJ666-Implementation/pages/Company/AgreementForm.jsp">Register<br/>Company</a></li>
              <li><a href="/PRJ666-Implementation/pages/About.jsp">About</a></li>
              <%
                if(userBean.isLogged())
                  out.println("<li><a href='/PRJ666-Implementation/pages/logout.jsp'>Logout</a></li>");
                else
                  out.println("<li><a href='/PRJ666-Implementation/pages/login.jsp'>Login</a></li>");
              %>
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
