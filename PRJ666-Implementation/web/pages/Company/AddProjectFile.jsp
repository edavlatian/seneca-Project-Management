<%-- 
    Document   : AddProjectFile
    Created on : Feb 29, 2012, 5:42:53 PM
    Author     : Edouard
--%>
<%@page import="java.util.List"%>
<%@page import="seneca.projectManagement.entity.Projects"%>
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
    Projectfile projFile = new Projectfile();
    if( id!=null && !id.equals("")){
        proj = userBean.getProject(Integer.parseInt(id));
        if( proj != null && proj.getProjectId() > 0){
            projFile.setProjectId(Integer.parseInt(id));
        }else{ id=""; }                         
    }else{ id=""; }
 %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
        <title>Add Project File to <%=proj.getPrjName()%></title>
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
            <!-- TODO : Check to see if id is empty. -->
        <h1>Enter file information below:</h1>
        <p><strong>Please note:</strong><br/> Files are not hosted on our servers and must be hosted at your leisure 
            somewhere appropriate.<br/> If files contain sensitive information considering encrypting them.</p>
        <form method="post" action="../validation/processFile.jsp">
            <input type="hidden" name="projectId" value="<%=proj.getProjectId()%>" />
            <input type="hidden" name="AddProjectFile" value="true" />
            <table>
                <tr>
                    <td>File Name:</br><em style="color: gray; font-size: 12px;">Database Connection Info</em></td>
                    <td><input style="vertical-align: top;" type="text" size="40" name="projectfileName" /></td>
                </tr>
                <tr>
                    <td>Description:</br><em style="color: gray; font-size: 12px;">Contains database connection <br/>information for our prj system.</em></td>
                    <td><textarea rows="3" cols="40" name="projectfileDescription" style="vertical-align: top;" /></textarea></td>
                </tr>
                <tr>
                    <td>File Location:</br><em style="color: gray; font-size: 12px;">The full url of the file.<br/>http://web.com/files/conn.doc</em></td>
                    <td style="vertical-align: top;"><input type="text" size="40" name="projectfileTheFile" /></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Add File" />
                    </td>
                </tr>
            </table>
        </form>
       </td>
      </tr>             
    </table>        
    </body>
</html>
