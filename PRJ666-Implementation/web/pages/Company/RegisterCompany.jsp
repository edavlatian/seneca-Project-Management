<%-- 
    Document   : RegisterCompany
    Created on : Feb 20, 2012, 2:03:43 PM
    Author     : KepneR
--%>

<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%@page import="seneca.projectManagement.databaseClasses.*" %>
<%@page import="seneca.projectManagement.utils.*" %>
<%@page import="seneca.projectManagement.entity.*" %>
<%
    Company company = new Company("", "");
    Accounts account = new Accounts( "", "", "", "", "", "");
    boolean errorFound = false;
    
    if(session.getAttribute("agreed") == null) {
        session.setAttribute("AgreementError", "You have not agreed to the agreement form.");
        response.sendRedirect("AgreementForm.jsp");
    } else {
        String cname = request.getParameter("id_cname");
        if(cname == null) {
            session.setAttribute("cname", "Cannot be empty!");
            errorFound = true;
        } else if(cname.isEmpty() == true) {
            session.setAttribute("cname", "Cannot be empty!");
            errorFound = true;
        } else if(cname.length() > 25) {
            session.setAttribute("cname", "Cannot be longer than 25 characters!");
            errorFound = true;
        } else {
            company.setCompanyname(cname);
        }

        String cphone = request.getParameter("id_cphone");
        if(cphone == null) {
            session.setAttribute("cphone", "Cannot be empty!");
            errorFound = true;
        } else if(cphone.isEmpty() == true) {
            session.setAttribute("cphone", "Cannot be empty!");
            errorFound = true;
        } else {
            if(Validation.isValidPhone(cphone) == true) {
                company.setCompanyphone(cphone);
            } else {
                session.setAttribute("cphone", "Invalid phone number!");
                errorFound = true;
            }
        }

        String fname = request.getParameter("id_fname");
        if(fname == null) {
            session.setAttribute("fname", "Cannot be empty!");
            errorFound = true;
        } else if(fname.isEmpty() == true) {
            session.setAttribute("fname", "Cannot be empty!");
            errorFound = true;
        } else {
            account.setUserfname(fname);
        }

        String lname = request.getParameter("id_lname");
        if(lname == null) {
            session.setAttribute("lname", "Cannot be empty!");
            errorFound = true;
        } else if(lname.isEmpty() == true) {
            session.setAttribute("lname", "Cannot be empty!");
            errorFound = true;
        } else {
            account.setUserlname(lname);
        }

        String user = request.getParameter("id_user");
        if(lname == null) {
            session.setAttribute("user", "Cannot be empty!");
            errorFound = true;
        } else if(lname.isEmpty() == true) {
            session.setAttribute("user", "Cannot be empty!");
            errorFound = true;
        } else {
            if(Validation.isValidUsername(user) == true) {
                account.setUseridentifier(user);
            } else {
                session.setAttribute("user", "Invalid username!");
                errorFound = true;
            }
        }

        String email = request.getParameter("id_email");
        if(email == null) {
            session.setAttribute("email", "Cannot be empty!");
            errorFound = true;
        } else if(email.isEmpty() == true) {
            session.setAttribute("email", "Cannot be empty!");
            errorFound = true;
        } else {
            if(Validation.isValidEmail(email) == true) {
                account.setUseremail(email);
            } else {
                session.setAttribute("email", "Invalid email address!");
                errorFound = true;
            }
        }

        String pass1 = request.getParameter("id_pass1");
        String pass2 = request.getParameter("id_pass2");
        if(pass1 == null) {
            session.setAttribute("pass1", "Cannot be empty!");
            errorFound = true;
        } else if(pass1.isEmpty() == true) {
            session.setAttribute("pass1", "Cannot be empty!");
            errorFound = true;
        } else if(pass1.length() < 5) {
            session.setAttribute("pass1", "Password length must be at least 6 characters.");
            errorFound = true;
        } else if(pass2 == null) {
            session.setAttribute("pass2", "Cannot be empty!");
            errorFound = true;
        } else if(pass2.isEmpty() == true) {
            session.setAttribute("pass2", "Cannot be empty!");
            errorFound = true;
        } else {
            if(Validation.isValidPassSimple(pass1, pass2) == true) {
                account.setPassword(pass1);
            } else {
                session.setAttribute("pass1", "Invalid password!");
                errorFound = true;
            }
        }

        if(errorFound == true) {
            session.setAttribute("Company", company);
            session.setAttribute("Account", account);
            response.sendRedirect("RegisterForm.jsp");
        } else {
            account.setUserrole("CR");
            account.setAccountstatus(0);
            if(userBean.addAccount(account) == false) {
                out.println("An unexpected error has occured while registering the account.");
                errorFound = true;
            }
            
            int userID = userBean.getAccounts(account.getUseridentifier()).getUserid();
            company.setRepid(userID);
            if(userBean.addCompany(company) == false) {
                out.println("An unexpected error has occured while registering the company.");
                errorFound = true;
            }
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="/pages/headers/loginHeader.jsp" />
        <%
            /*
            out.println(account.getUserid() + "<br/>");
            out.println(account.getUseridentifier() + "<br/>");
            out.println(account.getUserfname() + "<br/>");
            out.println(account.getUserlname() + "<br/>");
            out.println(account.getUseremail() + "<br/>");
            out.println(account.getUserrole() + "<br/>");
            out.println(account.getPassword() + "<br/>");
            out.print("<br/>");
            out.println(company.getCompanyname() + "<br/>");
            out.println(company.getCompanyphone() + "<br/>");
            out.println(company.getRepid() + "<br/>");
            */
            if(errorFound == false) {
                userBean.setLoggedAccount(account);
                out.println("<h1>Company Account successfully registered!</h1>");
                out.println("<a href=\"ProjectForm.jsp\">Click here to propose a project!</a>");
            }
        %>
    </body>
</html>
