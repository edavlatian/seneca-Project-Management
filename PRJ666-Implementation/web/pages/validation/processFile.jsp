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
