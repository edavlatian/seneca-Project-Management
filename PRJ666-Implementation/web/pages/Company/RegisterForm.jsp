<%-- 
    Document   : RegisterCompany
    Created on : Feb 20, 2012, 12:48:03 PM
    Author     : KepneR
--%>

<%
    if(request.getParameter("id_agree") == null) {
        session.setAttribute("AgreementError", "You have not agreed to the agreement form.");
        response.sendRedirect("AgreementForm.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Company</title>
    </head>
    <body>
        <h1>Register Company</h1>
        <form method="POST" action="RegisterCompany.jsp">
            <div style="width: 700px; background-color: lightskyblue; padding: 5px;">
                Company Information
            </div>
            <div style="width: 700px">
                <div style="float: left; width: 150px">Company Name:</div>
                <div style="float: left"><input type="text" name="id_cname" value=""></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("cname") != null) {
                            out.println("* " + session.getAttribute("cname").toString());
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Company Phone:</div>
                <div style="float: left"><input type="text" name="id_cphone" value=""></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("cphone") != null) {
                            out.println("* " + session.getAttribute("cphone").toString());
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
                <div style="float: left"><input type="text" name="id_fname" value=""></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("id_fname") != null) {
                            out.println("* " + session.getAttribute("id_fname").toString());
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Last Name:</div>
                <div style="float: left"><input type="text" name="id_lname" value=""></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("id_lname") != null) {
                            out.println("* " + session.getAttribute("id_lname").toString());
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Email Address:</div>
                <div style="float: left"><input type="text" name="id_email" value=""></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("id_email") != null) {
                            out.println("* " + session.getAttribute("id_email").toString());
                        }
                    %>
                </div>
                <div style="clear: both"><br/></div>
                <div style="float: left; width: 150px">Password:</div>
                <div style="float: left"><input type="password" name="id_pass1" value=""></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("id_pass1") != null) {
                            out.println("* " + session.getAttribute("id_pass1").toString());
                        }
                    %>
                </div>
                <div style="clear: both"></div>
                <div style="float: left; width: 150px">Again Password:</div>
                <div style="float: left"><input type="password" name="id_pass2" value=""></div>
                <div style="float: left; color: red">
                    <% 
                        if(session.getAttribute("id_pass2") != null) {
                            out.println("* " + session.getAttribute("id_pass2").toString());
                        }
                    %>
                </div>
                <div style="clear: both"></div>
            <div/>
            <div style="width: 700px; background-color: lightskyblue; padding: 5px;">
                <div style="float: left; width: 150px">&nbsp;</div>
                <div style="float: left">
                    <input type="submit" value="Submit">
                    <input type="reset" value="Clear">
                </div>
                <div style="clear: both"></div>
            </div>
        </form>
    </body>
</html>
