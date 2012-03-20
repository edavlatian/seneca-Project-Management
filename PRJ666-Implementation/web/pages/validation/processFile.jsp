<%-- 
    Document   : processFile
    Created on : Mar 6, 2012, 9:44:19 AM
    Author     : Edouard
--%>

<%@page import="seneca.projectManagement.entity.Projects"%>
<%@page import="seneca.projectManagement.entity.Projectfile"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />


<% 
    boolean errorFound = false;
    String errors="";
    if("true".equals(request.getParameter("AddProjectFile"))){  
            
        Projects proj = userBean.getProject(Integer.parseInt(request.getParameter("projectId")));
        Projectfile projFile = new Projectfile();
        projFile.setProjectId(proj.getProjectId());  
        projFile.setFileName("");
        projFile.setFileDescription("");
        projFile.setTheFile("");
        
        String mFileName = request.getParameter("projectfileName");
        String mDescription= request.getParameter("projectfileDescription"); 
        String mTheFile = request.getParameter("projectfileTheFile");
        
        if(mFileName == null || mFileName.isEmpty()){
            errorFound = true;
            errors += "&fname=1";
        }else if(mFileName.length() > 40){
            errorFound = true;
            errors += "&fname=2";
        }else{
            projFile.setFileName(mFileName);
        }
        
        if(mDescription == null || mDescription.isEmpty() ){
            errorFound = true;
            errors += "&fdesc=1";
        }else if(mDescription.length() > 120){
            errorFound = true;
            errors += "&fdesc=2";
        }else{
            projFile.setFileDescription(mDescription);
        }
        
        if(mTheFile == null || mTheFile.isEmpty()){
            errorFound = true;
            errors += "&ffile=1";
        }else if(mTheFile.length() > 500){
            errorFound = true;
            errors += "&ffile=2";
        }else{
            projFile.setTheFile(mTheFile);
        }
        
        if(!errorFound){
            if( userBean.addProjectFile(projFile) == false ){
                errorFound = true;
                response.sendRedirect("../Company/AddProjectFile.jsp?id="+projFile.getProjectId()+"&filefailed=1");
            }else{
                response.sendRedirect("../Company/ViewProjectDetails.jsp?id="+proj.getProjectId()+"&fileadded=yes" );       
            }
        }else{
            response.sendRedirect("../Company/AddProjectFile.jsp?id="+projFile.getProjectId()+errors);
        }        
    }else if("true".equals(request.getParameter("UpdateProjectFile"))){
        
        Projectfile projFile = userBean.getAProjectFile(Integer.parseInt(request.getParameter("fileId")));
        
        String mFileName = request.getParameter("projectfileName");
        String mDescription= request.getParameter("projectfileDescription"); 
        String mTheFile = request.getParameter("projectfileTheFile");
        
        if(mFileName == null || mFileName.isEmpty()){
            errorFound = true;
            errors += "&fname=1";
        }else if(mFileName.length() > 40){
            errorFound = true;
            errors += "&fname=2";
        }else{
            projFile.setFileName(mFileName);
        }
        
        if(mDescription == null || mDescription.isEmpty() ){
            errorFound = true;
            errors += "&fdesc=1";
        }else if(mDescription.length() > 120){
            errorFound = true;
            errors += "&fdesc=2";
        }else{
            projFile.setFileDescription(mDescription);
        }
        
        if(mTheFile == null || mTheFile.isEmpty()){
            errorFound = true;
            errors += "&ffile=1";
        }else if(mTheFile.length() > 500){
            errorFound = true;
            errors += "&ffile=2";
        }else{
            projFile.setTheFile(mTheFile);
        }
        if(!errorFound){
            if( userBean.updateProjectFile(projFile) == false ){
                errorFound = true;
                response.sendRedirect("../Company/ManageProjectFile.jsp?id="+projFile.getFileId()+"&filefailed=1");
            }else{
                response.sendRedirect("../Company/ViewProjectDetails.jsp?id="+projFile.getProjectId()+"&fileupdated=yes" );       
            }
        }else{
            response.sendRedirect("../Company/ManageProjectFile.jsp?id="+projFile.getProjectId()+errors);
        } 
    }else if("true".equals(request.getParameter("RemoveProjectFile"))){
        Projectfile projFile = userBean.getAProjectFile(Integer.parseInt(request.getParameter("fileId")));
        if(userBean.removeProjectFile(projFile) == false){
            response.sendRedirect("../Company/RemoveProjectFile.jsp?id="+projFile.getFileId()+"&filefailed=1");
        }else{
            response.sendRedirect("../Company/ViewProjectDetails.jsp?id="+projFile.getProjectId()+"&fileremoved=yes" );       
        }

    }
    %>
<!DOCTYPE html>
<html>
    <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
        <title>PRJ566 - Project Implementation</title>
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
            <li><a href="../Company/HomeCompany.jsp">Company Home Page</a></li>
            <li><a href="../Company/ViewAvailableTeams.jsp">Current Semester Teams</a></li>
            <li><a href="../Company/ProjectAgreementForm.jsp">Create New Project</a></li>
            <li><a href="../Company/ViewCompanyProjects.jsp">Your Projects</a></li>
            <li><a href="../Company/ManageCompanyInfo.jsp">Edit Company Info</a></li>
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
            <h1><%
            if(errorFound){
                out.println("Looks like something went wrong, the file was not added/changed.");
            }else{
                out.println("The file was successfully added/changed.");
            }
            %></h1>          
        </td>
      </tr>             
    </table>        
    </body>
</html>
