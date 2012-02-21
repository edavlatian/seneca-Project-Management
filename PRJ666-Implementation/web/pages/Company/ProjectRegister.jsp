<%-- 
    Document   : ProjectRegister
    Created on : Feb 20, 2012, 7:43:04 PM
    Author     : KepneR
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%@page import="seneca.projectManagement.databaseClasses.*" %>
<%@page import="seneca.projectManagement.utils.*" %>
<%
    Date date = new Date();
    DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
    Projects proj = new Projects("", "", "", "", "", df.format(date));
    Projectfile projFile = new Projectfile("", "", "");
    boolean errorFound = false;
    
    if(userBean.getIsLogged() == true) {
        if(userBean.getUserRole().equals("CR") == false) {
            session.setAttribute("Error", "You don't have permission to access the company page.");
            response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
        } else {
            String pname = request.getParameter("id_pname");
            if (pname == null) {
                session.setAttribute("pname", "Cannot be empty!");
                errorFound = true;
            } else if(pname.isEmpty() == true) {
                session.setAttribute("pname", "Cannot be empty!");
                errorFound = true;
            } else {
                if(Validation.isValidProject(pname) == true) {
                    proj.setPrjname(pname);
                } else {
                    session.setAttribute("pname", "Invalid project name!");
                    errorFound = true;
                }
            }

            String pdesc = request.getParameter("id_pdesc");
            if(pdesc == null) {
                session.setAttribute("pdesc", "Cannot be empty!");
                errorFound = true;
            } else if(pdesc.isEmpty() == true) {
                session.setAttribute("pdesc", "Cannot be empty!");
                errorFound = true;
            } else {
                proj.setDescription(pdesc);
            }

            String pcons = request.getParameter("id_pcons");
            if(pcons == null) {
                session.setAttribute("pcons", "Cannot be empty!");
                errorFound = true;
            } else if(pcons.isEmpty() == true) {
                session.setAttribute("pcons", "Cannot be empty!");
                errorFound = true;
            } else {
                proj.setPrjconstraints(pcons);
            }

            String flname = request.getParameter("id_flname");
            if(flname == null) {
                session.setAttribute("flname", "Cannot be empty!");
                errorFound = true;
            } else if(flname.isEmpty() == true) {
                session.setAttribute("flname", "Cannot be empty!");
                errorFound = true;
            } else {
                projFile.setFilename(flname);
            }

            String fldesc = request.getParameter("id_fldesc");
            if(fldesc == null) {
                session.setAttribute("fldesc", "Cannot be empty!");
                errorFound = true;
            } else if(fldesc.isEmpty() == true) {
                session.setAttribute("fldesc", "Cannot be empty!");
                errorFound = true;
            } else {
                projFile.setFiledescription(fldesc);
            }

            String fllink = request.getParameter("id_fllink");
            if(fllink == null) {
                session.setAttribute("fllink", "Cannot be empty!");
                errorFound = true;
            } else if(fllink.isEmpty() == true) {
                session.setAttribute("fllink", "Cannot be empty!");
                errorFound = true;
            } else {
                projFile.setThefile(fllink);
            }

            if(errorFound == true) {
                session.setAttribute("Project", proj);
                session.setAttribute("ProjectFile", projFile);
                response.sendRedirect("ProjectForm.jsp");
            } else {
                Company c = userBean.getCompany(userBean.getLoggedUser());
                proj.setStatus("PE");
                proj.setCompanyid(c.getCompanyid());
                if(userBean.addProject(proj) == false) {
                    out.println("An unexpected error has occured while registering the Project.");
                    errorFound = true;
                }

                int prjId = userBean.getProject(proj).getProjectid();
                projFile.setProjectid(prjId);
                if(userBean.addProjectFile(projFile) == false) {
                    out.println("An unexpected error has occured while registering the Project File.");
                    errorFound = true;
                }
            }
        }
    }
    else {
        errorFound = true;
        response.sendRedirect("/PRJ666-Implementation/pages/Home.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registering Project Proposal</title>
    </head>
    <body>
        <jsp:include page="/pages/headers/loginHeader.jsp" />
        <%
            if(errorFound == false) {
                /*
                out.print(userBean.getLoggedUser().getUseridentifier() + "<br/>");
                out.print(userBean.getLoggedUser().getAccountstatus() + "<br/>");
                out.print(userBean.getLoggedUser().getUserid() + "<br/>");
                out.print("<hr/>");
                Company c = userBean.getCompany(userBean.getLoggedUser());
                if(c != null) {
                    out.print(c.getCompanyid() + "<br/>");
                    out.print(c.getCompanyname() + "<br/>");
                    out.print(c.getCompanyphone() + "<br/>");
                }
                out.print("<hr/>");
                out.print(proj.getProjectid() + "<br/>");
                out.print(proj.getStatus() + "<br/>");
                out.print(proj.getPrjname() + "<br/>");
                out.print(proj.getDescription() + "<br/>");
                out.print(proj.getPrjconstraints() + "<br/>");
                out.print(proj.getAgreementdate() + "<br/>");
                out.print(proj.getCompanyid() + "<br/>");
                out.print(proj.getTeamid() + "<br/>");
                out.print(proj.getInstructorid() + "<br/>");
                out.print("<hr/>");
                out.print(projFile.getFileid() + "<br/>");
                out.print(projFile.getFilename() + "<br/>");
                out.print(projFile.getFiledescription() + "<br/>");
                out.print(projFile.getThefile() + "<br/>");
                out.print(projFile.getProjectid() + "<br/>");
                */
                out.println("<h1>Project Proposal has been successfully registered!</h1>");
            }
        %>
    </body>
</html>
