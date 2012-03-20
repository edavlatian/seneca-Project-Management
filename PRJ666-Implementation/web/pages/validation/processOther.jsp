<%-- 
    Document   : processOther
    Created on : Jan 26, 2012, 10:13:28 PM
    Author     : matthewschranz
--%>
<%@page import="seneca.projectManagement.entity.*"%>
<%@page import="seneca.projectManagement.utils.Email"%>

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
        }else if(mDesc.length() > 500){
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
    }

%>