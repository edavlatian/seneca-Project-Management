<%-- 
    Document   : ProjectForm
    Created on : Feb 20, 2012, 5:23:50 PM
    Author     : KepneR
--%>
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
    
    Projects proj = new Projects();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Project Proposal</title>
    </head>
    <body>
        <jsp:include page="/pages/headers/loginHeader.jsp" />
        <h1>Project Proposal</h1>
        <form method="POST" action="ProjectRegister.jsp">
            <div style="width: 700px; background-color: lightskyblue; padding: 5px;">
                Company Information 
            </div>
            <div style="width: 700px">
                <div style="float: left; width: 150px">Project Name:</div>
                <div style="float: left"><input type="text" name="id_pname" value=""></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("pname") != null) {
                            out.println("* " + session.getAttribute("pname").toString());
                            session.removeAttribute("pname");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Description:</div>
                <div style="float: left"><textarea name="id_pdesc" cols="40" rows="10"></textarea></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("pdesc") != null) {
                            out.println("* " + session.getAttribute("pdesc").toString());
                            session.removeAttribute("pdesc");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Constraints:</div>
                <div style="float: left"><textarea name="id_pcons" cols="40" rows="5"></textarea></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("pcons") != null) {
                            out.println("* " + session.getAttribute("pcons").toString());
                            session.removeAttribute("pcons");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Agreement Date:</div>
                <div style="float: left"><input type="text" name="id_pdate"></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("pdate") != null) {
                            out.println("* " + session.getAttribute("pdate").toString());
                            session.removeAttribute("pdate");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="width: 700px; background-color: lightskyblue; padding: 5px;">
                    <div style="float: left; width: 150px">&nbsp;</div>
                    <div style="float: left">
                        <input type="submit" value="Continue">
                    </div>
                    <div style="clear: both"></div>
                </div>
            </div>
        </form>
    </body>
</html>
