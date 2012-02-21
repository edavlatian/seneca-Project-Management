<%-- 
    Document   : RegisterCompany
    Created on : Feb 20, 2012, 12:48:03 PM
    Author     : KepneR
--%>

<%@page import="seneca.projectManagement.entity.*" %>
<%@page import="seneca.projectManagement.utils.*" %>
<%
    Company company = new Company();
    Accounts account = new Accounts();

    if(session.getAttribute("agreed") == null) {
        session.setAttribute("AgreementError", "You have not agreed to the agreement form.");
        response.sendRedirect("AgreementForm.jsp");
    }
    
    if(session.getAttribute("Company") != null) {
        company = (Company) session.getAttribute("Company");
    }
    if(session.getAttribute("Account") != null) {
        account = (Accounts) session.getAttribute("Account");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Company</title>
        <style type="text/css">
            input[type=text], textArea, input[type=password] {
                width: 300px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/pages/headers/loginHeader.jsp" />
        <h1>Register Company</h1>
        <form method="POST" action="RegisterCompany.jsp">
            <div style="width: 700px; background-color: lightskyblue; padding: 5px;">
                Company Information 
            </div>
            <div style="width: 700px">
                <div style="float: left; width: 150px">Company Name:</div>
                <div style="float: left"><input type="text" name="id_cname" value="<% out.println(company.getCompanyName()); %>"></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("cname") != null) {
                            out.println("* " + session.getAttribute("cname").toString());
                            session.removeAttribute("cname");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Company Phone:</div>
                <div style="float: left"><input type="text" name="id_cphone" value="<% out.println(company.getCompanyPhone()); %>"></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("cphone") != null) {
                            out.println("* " + session.getAttribute("cphone").toString());
                            session.removeAttribute("cphone");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
            <div/>
            <div style="width: 700px; background-color: lightskyblue; padding: 5px;">
                Account Information
            </div>
            <div style="width: 700px">
                <div style="float: left; width: 150px">First Name:</div>
                <div style="float: left"><input type="text" name="id_fname" value="<% out.println(account.getUserFName()); %>"></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("fname") != null) {
                            out.println("* " + session.getAttribute("fname").toString());
                            session.removeAttribute("fname");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Last Name:</div>
                <div style="float: left"><input type="text" name="id_lname" value="<% out.println(account.getUserLName()); %>"></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("lname") != null) {
                            out.println("* " + session.getAttribute("lname").toString());
                            session.removeAttribute("lname");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Email Address:</div>
                <div style="float: left"><input type="text" name="id_email" value="<% out.println(account.getUserEmail()); %>"></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("email") != null) {
                            out.println("* " + session.getAttribute("email").toString());
                            session.removeAttribute("email");
                        }
                    %>
                </div>
                <div style="clear: both"><br/></div>
                <div style="float: left; width: 150px">Username:</div>
                <div style="float: left"><input type="text" name="id_user" value="<% out.println(account.getUserIdentifier()); %>"></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("user") != null) {
                            out.println("* " + session.getAttribute("user").toString());
                            session.removeAttribute("user");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Password:</div>
                <div style="float: left"><input type="password" name="id_pass1" value=""></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("pass1") != null) {
                            out.println("* " + session.getAttribute("pass1").toString());
                            session.removeAttribute("pass1");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Again Password:</div>
                <div style="float: left"><input type="password" name="id_pass2" value=""></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("pass2") != null) {
                            out.println("* " + session.getAttribute("pass2").toString());
                            session.removeAttribute("pass2");
                        }
                    %>
                </div>
                <div style="clear: both"></div>
            <div/>
            <div style="width: 700px; background-color: lightskyblue; padding: 5px; text-align: right">
                <input type="submit" value="Continue">
            </div>
        </form>
    </body>
</html>
