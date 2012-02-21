<%-- 
    Document   : ProjectForm
    Created on : Feb 20, 2012, 5:23:50 PM
    Author     : KepneR
--%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%@page import="seneca.projectManagement.databaseClasses.*" %>
<%@page import="seneca.projectManagement.utils.*" %>
<%
    if(userBean.getIsLogged() == true) {
        if(userBean.getUserRole().equals("CR") == false) {
            session.setAttribute("Error", "You don't have permission to access the company page.");
            response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
        }
    }
    else {
        response.sendRedirect("/PRJ666-Implementation/pages/Home.jsp");
    }
    
    Date date = new Date();
    DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
    Projects proj = new Projects("", "", "", "", "", df.format(date));
    if(session.getAttribute("Project") != null) {
        proj = (Projects) session.getAttribute("Project");
    }
    
    Projectfile projFile = new Projectfile("", "", "");
    if(session.getAttribute("ProjectFile") != null) {
        projFile = (Projectfile) session.getAttribute("ProjectFile");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Project Proposal</title>
        <style type="text/css">
            input[type=text], textArea {
                width: 300px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/pages/headers/loginHeader.jsp" />
        <h1>Project Proposal</h1>
        <form method="POST" action="ProjectRegister.jsp">
            <div style="width: 700px; background-color: lightskyblue; padding: 5px;">
                Project Proposal Information 
            </div>
            <div style="width: 700px">
                <div style="float: left; width: 150px">Project Name:</div>
                <div style="float: left"><input type="text" name="id_pname" value="<% out.print(proj.getPrjname()); %>"></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("pname") != null) {
                            out.println("* " + session.getAttribute("pname").toString());
                            session.removeAttribute("pname");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Project Description:</div>
                <div style="float: left"><textarea name="id_pdesc" cols="40" rows="10"><% out.print(proj.getDescription()); %></textarea></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("pdesc") != null) {
                            out.println("* " + session.getAttribute("pdesc").toString());
                            session.removeAttribute("pdesc");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Project Constraints:</div>
                <div style="float: left"><textarea name="id_pcons" cols="40" rows="5"><% out.print(proj.getPrjconstraints()); %></textarea></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("pcons") != null) {
                            out.println("* " + session.getAttribute("pcons").toString());
                            session.removeAttribute("pcons");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
            </div>
            <div style="width: 700px; background-color: lightskyblue; padding: 5px;">
                Project Files and Links Information
            </div>
            <div style="width: 700px">
                <div style="float: left; width: 150px">File Name:</div>
                <div style="float: left"><input type="text" name="id_flname" value="<% out.print(projFile.getFilename()); %>"></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("flname") != null) {
                            out.println("* " + session.getAttribute("flname").toString());
                            session.removeAttribute("flname");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">File Description:</div>
                <div style="float: left"><textarea name="id_fldesc" cols="40" rows="5"><% out.print(projFile.getFiledescription()); %></textarea></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("fldesc") != null) {
                            out.println("* " + session.getAttribute("fldesc").toString());
                            session.removeAttribute("fldesc");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">File Link:</div>
                <div style="float: left"><input type="text" name="id_fllink" value="<% out.print(projFile.getThefile()); %>"></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("fllink") != null) {
                            out.println("* " + session.getAttribute("fllink").toString());
                            session.removeAttribute("fllink");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
            </div>
            <div style="width: 700px; background-color: lightskyblue; padding: 5px; text-align: right">
                <input type="submit" value="Continue">
            </div>
        </form>
    </body>
</html>
