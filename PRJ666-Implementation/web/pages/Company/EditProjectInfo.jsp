<%-- 
    Document   : EditProjectInfo
    Created on : Mar 20, 2012, 4:41:05 PM
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
    if( id!=null && !id.equals("")){
        proj = userBean.getProject(Integer.parseInt(id));
        if( proj != null && proj.getProjectId() > 0){
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
        <title>Edit Project Details</title>
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
        <%if(id.equals("x")){
            %><h1>You do not have permission to access this page.</h1><%
         }else if(!id.equals("")){%>
         <h1>Make changes below:</h1>
         <form method="post" action="../validation/processOther.jsp">
            <input type="hidden" name="projectId" value="<%=proj.getProjectId()%>" />
            <input type="hidden" name="UpdateProject" value="true" />            
            <table>
                <tr>
                    <td>Project Name:</br><em style="color: gray; font-size: 12px;">Hours of Service</em></td>
                    <td><input style="vertical-align: top;" type="text" size="40" name="projectName" value="<%=proj.getPrjName()%>"/></td>
                    <td>
                        <strong style="color:red;">
                            <%
                                if(request.getParameter("pname")!=null){
                                    if(request.getParameter("pname").equals("1")){
                                        %>Project name field cant be empty!<%
                                    }else if (request.getParameter("pname").equals("2")){
                                        %>Project name cant exceed 25 characters in length!<%
                                    }
                                }
                            %>                               
                        </strong>
                    </td>                 
                </tr>
                <tr style="vertical-align: top;">
                    <td>Description:</br><em style="color: gray; font-size: 12px;">This project will track<br/>the hours of service. Etc..</em></td>
                    <td><textarea rows="10" cols="40" name="projectDescription" style="vertical-align: top;" /><%=proj.getDescription()%></textarea></td>
                    <td>
                        <strong style="color:red;">
                            <%
                                if(request.getParameter("pdesc")!=null){
                                    if(request.getParameter("pdesc").equals("1")){
                                        %>Description field cant be empty!<%
                                    }else if (request.getParameter("pdesc").equals("2")){
                                        %>Description cant exceed 500 characters in length!<%
                                    }
                                }
                            %>
                        </strong>
                    </td>                
                </tr>
                <tr style="vertical-align: top;">
                    <td>Constraints:</br><em style="color: gray; font-size: 12px;">List of technologies:<br/>MySQL<br />Java</em></td>
                    <td><textarea rows="5" cols="40" name="projectConstraints" style="vertical-align: top;" /><%=proj.getPrjConstraints()%></textarea></td>
                    <td>
                        <strong style="color:red;">
                            <%
                                if(request.getParameter("pcons")!=null){
                                    if(request.getParameter("pcons").equals("1")){
                                        %>Constraints field cant be empty!<%
                                    }else if (request.getParameter("pcons").equals("2")){
                                        %>Constraints cant exceed 250 characters in length!<%
                                    }
                                }
                            %>
                        </strong>
                    </td>                
                </tr>
                <tr>
                    <td colspan="3">
                        <input type="submit" value="Save Changes" />
                    </td>
                </tr>                
            </table>
         </form>
        <%
         }else{
            %><h1>This project does not appear to be valid or does not exist.</h1><%
         }%>    
       </td>
      </tr>             
    </table>
    </body>
</html>            