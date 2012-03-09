<%-- 
    Document   : AddProjectComment
    Created on : Mar 5, 2012, 9:52:22 PM
    Author     : Edouard
--%>

<%@page import="seneca.projectManagement.entity.Comments"%>
<%@page import="seneca.projectManagement.entity.Projects"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<jsp:setProperty name="userBean" property="*" />
<%
    if(userBean.isLogged() == true) {
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
    Comments comment;
    if( id!=null && !id.equals("")){
        proj = userBean.getProject(Integer.parseInt(id));
        if( proj!= null && proj.getProjectId() > 0){
            if(proj.getStatus().equals("PA")){
                comment = new Comments();
                comment.setProjectId(proj.getProjectId());
                comment.setCommentStatus(0);
                comment.setCommentDescription("");
            }else{id="x";}
        }else{id="";}
    }else{id="";}
    
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
        <td style="background-image: url('../resources/images/header_bg.jpg'); height: 1px;">
          <ul>
            <li><a href="HomeCompany.jsp">Company Home</a></li>
            <li><a href="ViewAvailableTeams.jsp">Current Semester Teams</a></li>
            <li><a href="ProjectAgreementForm.jsp">Create New Project</a></li>
            <li><a href="ViewCompanyProjects.jsp">Your Projects</a></li>
            <li><a href="UpcomingMilestones.jsp">Upcoming Milestones</a></li>
            <li><a href="ManageCompanyInfo.jsp">Edit Company Info</a></li>
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
            <%
            if(id.equals("x")){
                %><h1>This project is not yet available for commentary.</h1><%
            }else if(id.equals("")){
                %><h1>This comment is not associated with a valid project.</h1><%
            }else{
                %>
                <h2>Please enter a comment bellow for:<br /> <%=proj.getPrjName()%></h2>
                <form action="../validation/processOther.jsp" method="post">
                    <textarea name="commentDescription" rows="8" cols="50"></textarea>
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
