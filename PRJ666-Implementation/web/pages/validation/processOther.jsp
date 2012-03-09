<%-- 
    Document   : processOther
    Created on : Jan 26, 2012, 10:13:28 PM
    Author     : matthewschranz
--%>
<%@page import="seneca.projectManagement.entity.Projects"%>
<%@page import="seneca.projectManagement.entity.Comments"%>
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
     if("true".equals(request.getParameter("AddComment"))){
         Projects proj = userBean.getProject(Integer.parseInt(request.getParameter("projectId")));
         Comments comment = new Comments();
         comment.setCommentId(proj.getProjectId());
         comment.setCommentStatus(0);
         
         String mDesc = request.getParameter("commentDescription");
         if(mDesc== null){
             errorFound = true;
         }else if(mDesc.length() > 500){
             errorFound = true;
         }else{
             comment.setCommentDescription(mDesc);
         }
         if(!errorFound){
            if(!userBean.newComment(comment)){
                errorFound = true;
            }else{
                //Have to send an email here
                /*
                Email emailer = new Email();
                emailer.sendEmail( "matthew.schranz@senecacollege.ca", "schranz.m@gmail.com",
                    "Comment was added", 
                    "This email is to inform you that a project comment has been submited."
                     + " using an outside email as the recipient.");
                */
                %><jsp:forward page="../Company/AddProjectComment.jsp?Added=Yes." /><%
            }
         }         
     }

%>