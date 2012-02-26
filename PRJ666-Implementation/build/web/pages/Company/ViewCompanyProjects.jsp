<%-- 
    Document   : ViewCompanyProjects
    Created on : Feb 15, 2012, 9:34:22 AM
    Author     : Edouard
--%>
<%@page import="java.util.List"%>
<%@page import="seneca.projectManagement.entity.Company"%>
<%@ page import="java.util.ArrayList, seneca.projectManagement.entity.Projects"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
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
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Company Projects</title>
    </head>
    <body>
        <table>
        <tr>
            <th colspan="5"><%=userBean.getCompany().getCompanyName()%> Project List</th>
        </tr>
        <tr>
            <th>ID</th>
            <th>Status</th>
            <th>Name</th>
            <th>Description</th>
            <th>Constraints</th>
        </tr>
        <%
        Company comp = userBean.getCompany();
        List<Projects> projects = userBean.getCompanyProjects( comp );
        if(projects.size()>0){
            for(int i=0; i < projects.size(); i++){
                Projects proj = new Projects();
                proj = projects.get(i);
        %>
        <tr>
        <td><%= proj.getProjectId() %></td>
        <td><%= proj.getStatus() %></td>
        <td><%= proj.getPrjName() %></td>
        <td><%= proj.getDescription() %></td>
        <td><%= proj.getPrjConstraints() %></td>
        </tr>
        <%
            }
        }else{
            %>
            <tr><td colspan="5">Sorry, there does not appear to be any projects associated with this company.</td></tr>
        <%
        }
        %>
        </table>
    </body>
</html>
