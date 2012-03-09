<%-- 
    Document   : ViewProjectDetails
    Created on : Feb 29, 2012, 4:39:22 PM
    Author     : Edouard
--%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="seneca.projectManagement.entity.Teams"%>
<%@page import="seneca.projectManagement.entity.Projects"%>
<%@page import="seneca.projectManagement.entity.Milestone"%>
<%@page import="seneca.projectManagement.entity.Projectfile"%>
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
    Projects proj =  new Projects();
    Teams team = new Teams();
    List<Milestone> projMilestones;
    List<Projectfile> projFiles;
    if( id!=null && !id.equals("")){
        proj = userBean.getProject(Integer.parseInt(id));
        if( proj != null && proj.getProjectId() > 0){
            team = userBean.getProjectTeam(Integer.parseInt(id));
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
        <title>Project #<%=id%></title>
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
        <% if(id!=""){
           projMilestones = userBean.getProjectMilestones(proj.getProjectId());
           projFiles = userBean.getProfileFiles(proj.getProjectId());
   %>
        <h1><%=proj.getPrjName()%></h1>
        <h2>Status: <%=proj.getStatus()%></h2>
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
            %><p> There are no files associated with this project</p><%
        }
        %>
        <% if(team!=null && team.getTeamId()!=0){%>
        <p>Assigned Team: <a href="../Team/TeamPage.jsp?id=<%=team.getTeamId()%>"><%=team.getTeamName()%></a></p>
        <%}else{%>
        <p><strong>Currently no team assigned</strong></p>
        <%}
        if(!projMilestones.isEmpty()){
            %>
            <table id="milestone_table">
              <tr>
                <th colspan="3">Milestones</th>
              </tr>
              <tr>
                  <th>Status</th>
                  <th>Description</th>
                  <th>Due Date</th>
              </tr>
              <%
              for(int i = 0; i < projMilestones.size(); i++){
               Milestone temp = new Milestone();
               temp = projMilestones.get(i);
               String s = new SimpleDateFormat("yyyy/MM/dd").format(temp.getDueDate());
                %><tr>
                    <td><%=temp.getMilestoneStatus()%></td>
                    <td><%=temp.getDescription()%></td>
                    <td><%=s%></td>
                  </tr><%
            }
            %>
            </table>
            <%
        }else{
            %><p>Currently there are no milestones associated with this project</p><%
        }
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
