<%-- 
    Document   : ManageProjectFile
    Created on : Feb 29, 2012, 5:52:30 PM
    Author     : Edouard
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
            Projects proj = userBean.getProject(projFile.getProjectId());
            if(userBean.getCompany().getCompanyId()!=proj.getCompanyId()){
                id="x";
            }
        }else{ id=""; }                         
    }else{ id=""; }
 %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
        <title>Manage Project File</title>
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
        <%if(id.equals("x")){
            %><h1>You do not have permission to access this page.</h1><%
         }else if(!id.equals("")){%>
        <h1>Make Changes Below:</h1>
        <p><strong>Please note:</strong><br/> Files are not hosted on our servers and must be hosted at your leisure 
            somewhere appropriate.<br/> If files contain sensitive information considering encrypting them.</p>
            <strong style="color:red;">
                <%
                    if(request.getParameter("filefailed")!=null){
                        if(request.getParameter("filefailed").equals("1")){
                            %>There was an error when saving the changes.<%
                        }
                    }
                %>                               
            </strong>        
        <form method="post" action="../validation/processFile.jsp">
            <input type="hidden" name="fileId" value="<%=projFile.getFileId()%>" />
            <input type="hidden" name="UpdateProjectFile" value="true" />            
            <table>
                <tr style="vertical-align: top;">
                    <td>File Name:</br><em style="color: gray; font-size: 12px;">Database Connection Info</em></td>
                    <td><input style="vertical-align: top;" type="text" size="40" name="projectfileName" value="<%=projFile.getFileName()%>"/></td>
                    <td>
                        <strong style="color:red;">
                            <%
                                if(request.getParameter("fname")!=null){
                                    if(request.getParameter("fname").equals("1")){
                                        %>File name field can't be empty!<%
                                    }else if (request.getParameter("fname").equals("2")){
                                        %>File name can't exceed 40 characters in length!<%
                                    }
                                }
                            %>                               
                        </strong>
                    </td>                 
                </tr>
                <tr style="vertical-align: top;">
                    <td>Description:</br><em style="color: gray; font-size: 12px;">Contains database connection <br/>information for our prj system.</em></td>
                    <td><textarea rows="3" cols="40" name="projectfileDescription" style="vertical-align: top;" /><%= projFile.getFileDescription()%></textarea></td>
                    <td>
                        <strong style="color:red;">
                            <%
                                if(request.getParameter("fdesc")!=null){
                                    if(request.getParameter("fdesc").equals("1")){
                                        %>Description field can't be empty!<%
                                    }else if (request.getParameter("fdesc").equals("2")){
                                        %>Description can't exceed 65000 characters in length!<%
                                    }
                                }
                            %>
                        </strong>
                    </td>                
                </tr>
                <tr style="vertical-align: top;">
                    <td>File Location:</br><em style="color: gray; font-size: 12px;">The full URL of the file.<br/>http://web.com/files/conn.doc</em></td>
                    <td style="vertical-align: top;"><input type="text" size="40" name="projectfileTheFile" value="<%=projFile.getTheFile()%>"/></td>
                    <td>
                        <strong style="color:red;">
                            <%
                                if(request.getParameter("ffile")!=null){
                                    if(request.getParameter("ffile").equals("1")){
                                        %>File Location field can't be empty!<%
                                    }else if (request.getParameter("ffile").equals("2")){
                                        %>File Location field can't exceed 65000 characters in length!<%
                                    }
                                }
                            %>                                
                        </strong>
                    </td>                 
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Save Changes" />
                    </td>
                </tr>
            </table>
        </form>
        <%
         }else{
            %><h1>This file does not appear to be valid or does not exist.</h1><%
         }%>
       </td>
      </tr>             
    </table>        
    </body>
</html>
