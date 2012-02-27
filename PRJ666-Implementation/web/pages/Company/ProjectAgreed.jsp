<%-- 
    Document   : Agreed
    Created on : Feb 20, 2012, 2:09:06 PM
    Author     : KepneR
--%>

<%
    if(request.getParameter("id_agree") == null) {
        session.setAttribute("AgreementError", "You have not agreed to the agreement form.");
        response.sendRedirect("ProjectAgreementForm.jsp");
    } else {
        session.setAttribute("agreed", 1);
        response.sendRedirect("ProjectForm.jsp");
    }
%>