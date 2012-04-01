<%-- 
    Document   : processOther
    Created on : Jan 26, 2012, 10:13:28 PM
    Author     : matthewschranz
--%>
<%@page import="seneca.projectManagement.entity.*"%>
<%@page import="seneca.projectManagement.utils.Email"%>
<%@page import="java.util.List"%>

<%@ page
  import="seneca.projectManagement.utils.CryptoUtil,
    seneca.projectManagement.entity.*,
    java.sql.SQLException"
  language="java" contentType="text/html; charset=ISO-8859-1"
  pageEncoding="ISO-8859-1"%>
  
  <jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />

<%
    boolean errorFound = false;
    String errors="";
    if("true".equals(request.getParameter("AddComment"))){
        Projects proj = userBean.getProject(Integer.parseInt(request.getParameter("projectId")));
        Comments comment = new Comments();
        comment.setProjectId(proj.getProjectId());
        comment.setCommentStatus(0);

        String mDesc = request.getParameter("commentDescription");
        if(mDesc == null || mDesc.isEmpty()){
            errorFound = true;
            errors+="&cdesc=1";
        }else if(mDesc.length() > 65000){
            errorFound = true;
            errors+="&cdesc=2";
        }else{
            comment.setCommentDescription(mDesc);
        }
    
        if(!errorFound){
            if(userBean.newComment(comment) == false){
                response.sendRedirect("../Company/AddProjectComment.jsp?id="+proj.getProjectId()+"commentfail=1" );
            }else{
            //TODO: Have to send an email here
                response.sendRedirect("../Company/ViewProjectDetails.jsp?id="+proj.getProjectId()+"&commentsubmit=yes" );
            }
        }else{
            response.sendRedirect("../Company/AddProjectComment.jsp?id="+proj.getProjectId()+errors);
        }
    }else if("true".equals(request.getParameter("UpdateProject"))){
        Projects proj = userBean.getProject(Integer.parseInt(request.getParameter("projectId")));
        
        String mName = request.getParameter("projectName");
        String mDescription = request.getParameter("projectDescription");
        String mConstraints = request.getParameter("projectConstraints");
        
        if(mName == null || mName.isEmpty()){
            errorFound = true;
            errors += "&pname=1";
        }else if(mName.length() > 25){
            errorFound = true;
            errors += "&pname=2";
        }else{
            proj.setPrjName(mName);
        }
        
        if(mDescription == null || mDescription.isEmpty()){
            errorFound = true;
            errors += "&pdesc=1";
        }else if(mDescription.length() > 65000){
            errorFound = true;
            errors += "&pdesc=2";
        }else{
            proj.setDescription(mDescription);
        }
        
        if(mConstraints == null || mConstraints.isEmpty()){
            errorFound = true;
            errors += "&pcons=1";
        }else if(mConstraints.length() > 65000){
            errorFound = true;
            errors += "&pcons=2";
        }else{
            proj.setPrjConstraints(mConstraints);
        }
        
        if(!errorFound){
            if(userBean.updateProject(proj) == false){
                response.sendRedirect("../Company/EditProjectInfo.jsp?id="+proj.getProjectId()+"&failed=1" );
            }else{
                response.sendRedirect("../Company/ViewProjectDetails.jsp?id="+proj.getProjectId()+"&updatedproject=yes" );
            }
        }else{
            response.sendRedirect("../Company/EditProjectInfo.jsp?id="+proj.getProjectId()+errors);
        }                                                 
    }else if("true".equals(request.getParameter("RemoveProject"))){
        Projects proj = userBean.getProject(Integer.parseInt(request.getParameter("projectId")));
        List <Projectfile> projFiles = userBean.getProfileFiles(proj.getProjectId());  
        if(userBean.removeProject(proj) == false){
            response.sendRedirect("../Company/RemoveProject.jsp?id="+proj.getProjectId()+"&removefail=1");
        }else{
            if(projFiles.size() > 0){
                for(int i = 0; i < projFiles.size();i++){
                    userBean.removeProjectFile(projFiles.get(i));
                }
            }
            response.sendRedirect("../Company/ViewCompanyProjects.jsp?id="+proj.getProjectId()+"&projectdeleted=yes" );       
        }

    }

%>