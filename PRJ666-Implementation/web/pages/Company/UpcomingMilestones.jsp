<%-- 
    Document   : UpcomingMilestones
    Created on : Mar 5, 2012, 10:03:49 PM
    Author     : Edouard
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="seneca.projectManagement.entity.Projects"%>
<%@page import="java.util.List"%>
<%@page import="seneca.projectManagement.entity.Milestone"%>
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
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
        <title>Available Teams</title>
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
            <h1>Milestones for the next 30 days:</h1>
            <%
            
            List<Projects> projects = userBean.getCompanyProjects(userBean.getCompany()); //Gets a list of company projects
            if(projects.size() > 0){ //Check if there are any projects.
                %>
              <table id="upcoming_milestone_table">
                <%
                for(int i = 0; i < projects.size(); i++ ){ //For every project
                    if(projects.get(i).getStatus().equals("PR") || projects.get(i).getStatus().equals("MA")){ // Check if the project is proceeded or matched
                  %>
                  <tr><td colspan="4"><a href="ViewProjectDetails.jsp?id=<%=projects.get(i).getProjectId()%>"><%=projects.get(i).getPrjName()%></a></td></tr>
                  <%
                        List<Milestone> prjMilestones = userBean.getProjectMilestones(projects.get(i).getProjectId()); //Get a list of milestones
                        if(prjMilestones.size()>0){ //Check if there are milestones
                            for( int y = 0; y < prjMilestones.size();y++){ //For every milestone
                                
                  %>
                  <tr>
                      <td>&nbsp;</td>
                      <td><%=prjMilestones.get(y).getMilestoneName()%></td>
                      <td><%=prjMilestones.get(y).getDescription()%></td>
                      <td><%=prjMilestones.get(y).getMilestoneStatus()%></td>
                      <td><%=new SimpleDateFormat("yyyy/MM/dd").format(prjMilestones.get(y).getDueDate())%></td></tr>          
                  <%
                            }
                        }else{
                            %>
                  <tr><td colspan="4">This project does not have any milestones</td></tr>
                            <%
                        }
                    }
                }
                %>
              </table>
                <%
            }
           
            %>
        </td>
      </tr>             
    </table>
    </body>
</html>
