<%-- 
    Document   : AddProjectComment
    Created on : Mar 5, 2012, 9:52:22 PM
    Author     : Edouard
--%>

<%@page import="seneca.projectManagement.entity.Company"%>
<%@page import="seneca.projectManagement.entity.Accounts"%>
<%@page import="seneca.projectManagement.entity.Comments"%>
<%@page import="seneca.projectManagement.entity.Projects"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<jsp:setProperty name="userBean" property="*" />
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
    String id = request.getParameter("id");
    Projects proj = new Projects();
    if( id!=null && !id.equals("")){
        proj = userBean.getProject(Integer.parseInt(id));
        if( proj!= null && proj.getProjectId() > 0){
            if(proj.getStatus().equals("PA")){
                if( userBean.checkProjectComments(proj.getProjectId()).intValue() > 0 ){
                    id="z"; //Comments already exist.
                }else{
                  if(userBean.getCompany().getCompanyId()!= proj.getCompanyId() ){
                    id="";
                  }
                }
            }else{
                id="x"; //Project is not yet in PA status.
            }
        }else{
            id="q"; // Project does not exist.
        }
    }else{
        id=""; // The id is either null or empty.
    }
    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
    <title>PRJ566 - Company Home</title>
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
              Company temp_c = userBean.getCompany();
              out.print("Hello, Company " + temp_c.getCompanyName());
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
        <td><%
            if(id.equals("x")){
                %>
                <h1>This project is not yet available for commentary.</h1>
                <%
            }else if(id.equals("q")){
                %>
                <h1>The project used to get to this page is not valid.</h1>
                <%
            }else if(id.equals("z")){
                 %>
                 <h1>A comment has already been submitted for this project.</h1>
                 <%
            }else if(id.equals("")){
                %>
                <h1>Cant add a comment to this project.</h1>
                <%                
            }else{
                %>
                <h2>Please enter a comment bellow for:<br /> <%=proj.getPrjName()%></h2>
                <strong style="color:red;">
                    <%
                        if(request.getParameter("commentfail")!=null){
                            if(request.getParameter("commentfail").equals("1")){
                                %>There was an error when submitting the comment.<%
                            }
                        }
                    %>                               
                </strong>
                <p><%=userBean.checkProjectComments(proj.getProjectId())%></p>
                <form action="../validation/processOther.jsp" method="post">
                    <textarea name="commentDescription" rows="10" cols="50"></textarea>
                    <strong style="color:red;">
                        <%
                            if(request.getParameter("cdesc")!=null){
                                if(request.getParameter("cdesc").equals("1")){
                                    %>Comment Field cant be empty!!<%
                                }else if (request.getParameter("cdesc").equals("2")){
                                    %>Comment cant exceed 500 characters in length!<%
                                }
                            }
                        %>                               
                    </strong>
                    <input type="hidden" name="projectId" value="<%=proj.getProjectId()%>" />
                    <input type="hidden" name="AddComment" value="true" /><br />
                    <input type="submit" value="Submit for Approval" />
                </form>
                <%
            }
            %>
          
        </td>
      </tr>             
    </table>
  </body>
</html>
