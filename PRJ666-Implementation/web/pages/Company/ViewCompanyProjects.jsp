<%-- 
    Document   : ViewCompanyProjects
    Created on : Feb 15, 2012, 9:34:22 AM
    Author     : Edouard
--%>
    
<%@page import="java.util.List"%>
<%@page import="seneca.projectManagement.entity.*"%>
<%@ page import="java.util.ArrayList, seneca.projectManagement.entity.Projects"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%
    if(userBean.isLogged() == true && userBean != null) {
        if(userBean.getLoggedUser().getUserRole().equals("CR") == false) {
            session.setAttribute("Error", "You don't have permission to access the company page.");
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
        <title>Company Projects</title>
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
        <td style="background-image: url('../resources/images/header_bg.jpg')">
          <ul>
            <li><a href="/PRJ666-Implementation/pages/Company/HomeCompany.jsp">Company Home</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ProjectAgreementForm.jsp">Create New Project</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ViewCompanyProjects.jsp">Your Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ManageCompanyInfo.jsp">Edit Company Info</a></li>
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
            <strong style="color:red;">
                <%
                    if(request.getParameter("projectdeleted")!=null){
                        if(request.getParameter("projectdeleted").equals("yes")){
                            %>The pending project was deleted.<%
                        }
                    }            
                %> 
            </strong>
            <h1><%=userBean.getCompany().getCompanyName()%> Project List</h1>
        <table>
        <tr>
            <th>Status</th>
            <th>Project Name</th>
            <th>Description</th>
            <!-- <th>Constraints</th> -->
        </tr>
        <%
        Company comp = userBean.getCompany();
        List<Projects> projects = userBean.getCompanyProjects( comp );
        if(projects.size()>0){
            for(int i=0; i < projects.size(); i++){
                Projects proj = new Projects();
                proj = projects.get(i);
        %>
        <tr>
                <td><%= proj.getStatus() %></td>
                <td><a href="ViewProjectDetails.jsp?id=<%=proj.getProjectId()%>"><%= proj.getPrjName() %></a></td>
                <%
                String desc = proj.getDescription();
                if (desc.length() > 50){
                    desc = proj.getDescription().substring(0, 50) + "...";
                }
                %>
                <td><%=desc%></td>
        </tr>
        <%
            }
        }else{
            %>
            <tr><td colspan="3">Sorry, there does not appear to be any projects associated with this company.</td></tr>
        <%
        }
        %>
        </table>
       </td>
      </tr>             
    </table>  
    </body>
</html>
