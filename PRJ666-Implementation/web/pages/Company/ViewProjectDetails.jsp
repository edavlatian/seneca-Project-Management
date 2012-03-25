<%-- 
    Document   : ViewProjectDetails
    Created on : Feb 29, 2012, 4:39:22 PM
    Author     : Edouard
--%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
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
    Projects proj =  new Projects();
    Teams team = new Teams();
    List<Projectfile> projFiles;
    if( id!=null && !id.equals("")){
        proj = userBean.getProject(Integer.parseInt(id));
        if( proj != null && proj.getProjectId() > 0){
            team = userBean.getProjectTeam(Integer.parseInt(id));
            if(userBean.getCompany().getCompanyId()!= proj.getCompanyId() ){
                id="x";
            }
        }else{
            id="";
        }
    }else{
        id="";
    }
    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
        <title>Project Details</title>
    </head>
    <body>
    <table> 
      <tr>
        <td colspan="2">
          <table width="100%">
            <tr>
              <td width="402" style="background-image: url('../resources/images/header_left.jpg'); background-repeat: no-repeat;">&nbsp;</td>
              <td style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;" width="800">
                <a href="/PRJ666-Implementation/pages/Home.jsp" style="color: black;"><center><h2>WELCOME TO PRJ566<br/> Project Planning and Management</h2></center></a>
              </td>
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
            <li><a href="/PRJ666-Implementation/pages/Company/HomeCompany.jsp">Home</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ProjectAgreementForm.jsp">Create<br/>New<br/>Project</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ViewCompanyProjects.jsp">Your<br/>Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ManageCompanyInfo.jsp">Edit<br/>Company<br/>Information</a></li>
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
        <% if(id.equals("x")){
            %><h1>You do not have permission to access this page.</h1><%
         }else if(!id.equals("")){
           projFiles = userBean.getProfileFiles(proj.getProjectId());  
   %>
            <strong style="color:red;">
                <%
                    if(request.getParameter("commentsubmit")!=null){
                        if(request.getParameter("commentsubmit").equals("yes")){
                            %>A comment was submitted for approval.<%
                        }
                    }
                    if(request.getParameter("fileadded")!=null){
                        if(request.getParameter("fileadded").equals("yes")){
                            %>File was successfully added.<%
                        }
                    }
                    if(request.getParameter("fileupdated")!=null){
                        if(request.getParameter("fileupdated").equals("yes")){
                            %>File was successfully updated.<%
                        }
                    }    
                    if(request.getParameter("fileremoved")!=null){
                        if(request.getParameter("fileremoved").equals("yes")){
                            %>File was successfully removed.<%
                        }
                    }
                    if(request.getParameter("updatedproject")!=null){
                        if(request.getParameter("updatedproject").equals("yes")){
                            %>Project was successfully updated.<%
                        }
                    }                              
                %>                               
            </strong>    
        <h1><%=proj.getPrjName()%></h1>
        <h2>Status: <%=proj.getStatus()%></h2>
        <%
        if(proj.getStatus().equals("PE")){
            %>
            <p><strong style="color:red;">This project has not yet been approved.<br/>You are able to edit the project details before it is approved</strong></p>
            <a href="EditProjectInfo.jsp?id=<%=proj.getProjectId()%>">Click here to edit</a><br/>
            <a href="RemoveProject.jsp?id=<%=proj.getProjectId()%>">Click here to delete</a>            
            <%
        }
        %>
        <p>Description: <%=proj.getDescription()%></p>
        <p><strong>Constraints:</strong> <%=proj.getPrjConstraints()%></p>
        <%if(!projFiles.isEmpty()){
            %>
            <table id="filelist_table">
                <tr><th colspan="2">Project File List</tr>
                <tr>
                    <th>Description</th>
                    <th>The File</th>
                    <th>Edit</th>
                    <th>Remove</th>
                </tr>
                <%
                for(int i=0; i < projFiles.size(); i++){
                    Projectfile temp = new Projectfile();
                    temp = (Projectfile)projFiles.get(i);
                    %>
                    <tr>
                        <td><%=temp.getFileDescription()%></td>
                        <td><a href="<%=temp.getTheFile()%>"><%=temp.getFileName()%></a></td>
                        <td><a href="ManageProjectFile.jsp?id=<%=temp.getFileId()%>">EDIT</a></td>
                        <td><a href="RemoveProjectFile.jsp?id=<%=temp.getFileId()%>">DELETE</a></td>
                    </tr>
                    <%
                }
                %>
                <tr>
                    <td><a href="AddProjectFile.jsp?id=<%=id%>">Add Project File</td>
                </tr>
            </table>
               <%    
        }else{
            %><p> There are no files associated with this project</p>
             <% if(!proj.getStatus().equals("PA")){%>
            <a href="AddProjectFile.jsp?id=<%=id%>">Add Project File</a></p>
            <%}            
        }
        %>
        <% if(team!=null && team.getTeamId()!=0){%>
        <p>Assigned Team: <a href="#"><%=team.getTeamName()%></a></p>
        <%}else{%>
        <p><strong>Currently no team assigned</strong></p>
        <%}
          if(proj.getStatus().equals("PA")){
        %><a href="AddProjectComment.jsp?id=<%=id%>">Click Here to add a comment to this project</a><%
          }
        }else{
        %><h1>This project does not appear to be valid or does not exist.</h1><%
        }
        %>
       </td>
      </tr>             
    </table>
    </body>
</html>
