<%-- 
    Document   : AgreementForm
    Created on : Feb 20, 2012, 1:28:48 PM
    Author     : KepneR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Agreement Form</h1>
        <form method="POST" action="RegisterForm.jsp">
            <div style="width: 700px">
                <iframe width="700" height="300" src="Agreement.html"></iframe><br/>
            </div>
            <div style="width: 700px; text-align: right">
                <input type="checkbox" name="id_agree" value="agree" /> Yes, I agree to the above.
                <input type="submit" value="Continue" />
            <div>
            <div style="width: 700px; color: red">
            <%
                if(session.getAttribute("AgreementError") != null) {
                    out.println(session.getAttribute("AgreementError"));
                    session.removeAttribute("AgreementError");
                }
            %>
            </div>
        </form>
    </body>
</html>
