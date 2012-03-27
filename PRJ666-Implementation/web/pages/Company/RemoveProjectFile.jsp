<%-- 
    Document   : RemoveProjectFile
    Created on : Mar 19, 2012, 12:23:42 PM
    Author     : win7user
--%>

<%@page import="java.util.List"%>
<%@page import="seneca.projectManagement.entity.*"%>
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
    Projectfile projFile = new Projectfile();
    if( id!=null && !id.equals("")){
        projFile = userBean.getAProjectFile(Integer.parseInt(id));
        if( projFile != null && projFile.getProjectId() > 0){
            //Something Goes here
        }else{ id=""; }                         
    }else{ id=""; }
 %>
 <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
        <title>Manage Project File: <%=projFile.getFileName()%></title>
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
        <td style="background-image: url('../resources/images/header_bg.jpg')">
          <ul>
            <li><a href="HomeCompany.jsp">Company Home</a></li>
            <li><a href="ProjectAgreementForm.jsp">Create New Project</a></li>
            <li><a href="ViewCompanyProjects.jsp">Your Projects</a></li>
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
            <h1>Delete Project File?</h1>
            <p>If you are sure you want to delete the file below, please click the delete button. <br />Otherwise you may navigate elsewhere.</p>
            <strong>File: <a href="<%=projFile.getTheFile() %>"><%=projFile.getFileName() %></a></strong><br />
            <strong>Description: </strong><em><%=projFile.getFileDescription() %></em> <br /><br />
            <strong style="color:red;">
                <%
                    if(request.getParameter("filefailed")!=null){
                        if(request.getParameter("filefailed").equals("1")){
                            %>There was an error when removing the file.<%
                        }
                    }
                %>                               
            </strong> 
            <form method="post" action="../validation/processFile.jsp">
                <input type="hidden" name="fileId" value="<%=projFile.getFileId()%>" />
                <input type="hidden" name="RemoveProjectFile" value="true" />            
                <input type="submit" value="Delete" />
            </form>
        </td>
      </tr>
    </table>        
    </body>
</html>