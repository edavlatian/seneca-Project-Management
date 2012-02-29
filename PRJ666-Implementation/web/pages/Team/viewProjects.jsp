<%-- 
    Document   : viewProjects
    Created on : Feb 26, 2012, 10:05:52 AM
    Author     : matthewschranz
--%>

<%@page import="java.util.List"%>
<%@page import="seneca.projectManagement.entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
  <jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession"
               scope="session" />
  <jsp:setProperty name="userBean" property="*" />
<%
    if(userBean.isLogged() == true) {
        if(userBean.getLoggedUser().getUserRole().equals("TL")) {
          if(userBean.getTeam().getHasRegistered() != 1)
            response.sendRedirect("publishTeamPage.jsp");
        }
        else if(userBean.getLoggedUser().getAccountStatus() != 1) {
          session.setAttribute("Error", "Account has not been activated yet.");
          response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
        }
    }
    else {
        response.sendRedirect("/PRJ666-Implementation/pages/Home.jsp");
    }
%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
    <script type="text/javascript" src="../resources/js/pageStuff.js"></script>
    <title>PRJ566 - Team View Available Projects</title>
  </head>
  <body>
    <table> 
      <tr>
        <td colspan="2">
          <table width="100%">
            <tr>
              <td width="402" style="background-image: url('../resources/images/header_left.jpg'); background-repeat: no-repeat;">&nbsp;</td>
              <td style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;" width="800"><center><h2>WELCOME TO PRJ566<br/> Project Planning and Management</h2></center></td>
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
        <td style="background-image: url('../resources/images/header_bg.jpg')">
          <ul>
            <li><a href="teamHome.jsp">Team Home</a></li>
			      <li><a href="#">Rank Projects</a></li>
		        <li><a href="editTeamPage.jsp">Manage Team Page</a></li>
            <li><a href="#">Manage Project Milestones</a></li>
            <li><a href="viewProjects.jsp">View Projects</a></li>
		      </ul>
          <div style="float: right;">
            <ul>
              <li><a href="../logout.jsp">Logout</a></li>
            </ul>
          </div>
        </td>
      </tr>
      <tr class="projects">
        <td><h3 class="title">Available Projects</h3></td>
      </tr>
      <%
        List<Projects> projects = userBean.getAvailableProjects( "AV" );
        Company comp;
        
        if( !projects.isEmpty() ) {
          for( int i = 0, len = projects.size(); i < len; i++){
            Projects proj = projects.get( i );
            comp = userBean.getCompanyByID( proj.getCompanyId() );
            out.println( "<tr><td>" );
            out.println( "Company Name: " + comp.getCompanyName() + "<br/>" );
            out.println( "Company Telephone: " + comp.getCompanyPhone() + "<br/><br/>" );
            out.println( "About Us: TODO: Debate adding additional column to Company Table <br/><br/>" );
            out.println( "Project Name: " + proj.getPrjName() + "&#09;<button onclick='displayDetails( this )'>"
                    + "Show Details</button><br/>" );
            out.println( "Status: " + proj.getStatus() + "<br/><br/>" );
            out.println( "<div style='display: none'>Project Description: " + proj.getDescription() 
                    + "</br>");
            out.println( "Project Constraints:<br/>" + proj.getPrjConstraints() + "</div>");
            out.println( "</td></tr>" );
          }
        }
        else{
          out.print( "<tr class='projects'><td>There were no available projects.</td></tr>" );
        }
      %>
    </table>
  </body>
</html>
