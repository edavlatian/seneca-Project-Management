<%-- 
    Document   : ProjectRegister
    Created on : Feb 20, 2012, 7:43:04 PM
    Author     : KepneR
--%>

<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%@page import="seneca.projectManagement.entity.*" %>
<%@page import="seneca.projectManagement.utils.*" %>
<%
    Projects proj = new Projects();
    proj.setPrjName("");
    proj.setDescription("");
    proj.setPrjConstraints("");
    
    Projectfile projFile = new Projectfile();
    projFile.setFileName("");
    projFile.setFileDescription("");
    projFile.setTheFile("");
    
    boolean errorFound = false;
    
    if(userBean.isLogged() == true && userBean != null) {
        if(userBean.getLoggedUser().getUserRole().equals("CR") == false) {
            session.setAttribute("Error", "You don't have permission to access the company page.");
            response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
        } else if(session.getAttribute("agreed") == null) {
            session.setAttribute("AgreementError", "You have not agreed to the agreement form.");
            response.sendRedirect("ProjectAgreementForm.jsp");
        } else {
            String pname = request.getParameter("id_pname");
            if (pname == null) {
                session.setAttribute("pname", "Cannot be empty!");
                errorFound = true;
            } else if(pname.isEmpty() == true) {
                session.setAttribute("pname", "Cannot be empty!");
                errorFound = true;
            } else if(pname.length() > 20) {
                session.setAttribute("pname", "Cannot be longer than 20 characters!");
                errorFound = true;
            } else {
                if(Validation.isValidProject(pname) == true) {
                    proj.setPrjName(pname);
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
            } else if(pdesc.length() > 500) {
                session.setAttribute("pdesc", "Cannot be longer than 500 characters!");
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
            } else if(pcons.length() > 250) {
                session.setAttribute("pcons", "Cannot be longer than 250 characters!");
                errorFound = true;
            } else {
                proj.setPrjConstraints(pcons);
            }

            String flname = request.getParameter("id_flname");
            if(flname == null) {
                //session.setAttribute("flname", "Cannot be empty!");
                //errorFound = true;
                flname = "";
            } else if(flname.isEmpty() == true) {
                //session.setAttribute("flname", "Cannot be empty!");
                //errorFound = true;
                flname = "";
            } else {
                projFile.setFileName(flname);
            }

            String fldesc = request.getParameter("id_fldesc");
            if(fldesc == null) {
                //session.setAttribute("fldesc", "Cannot be empty!");
                //errorFound = true;
            } else if(fldesc.isEmpty() == true) {
                //session.setAttribute("fldesc", "Cannot be empty!");
                //errorFound = true;
                fldesc = "";
            } else {
                projFile.setFileDescription(fldesc);
            }

            String fllink = request.getParameter("id_fllink");
            if(fllink == null) {
                //session.setAttribute("fllink", "Cannot be empty!");
                //errorFound = true;
            } else if(fllink.isEmpty() == true) {
                //session.setAttribute("fllink", "Cannot be empty!");
                //errorFound = true;
                fllink = "";
            } else {
                projFile.setTheFile(fllink);
            }

            if(errorFound == true) {
                session.setAttribute("Project", proj);
                session.setAttribute("ProjectFile", projFile);
                response.sendRedirect("ProjectForm.jsp");
            } else {
                Company c = userBean.getCompany();
                proj.setStatus("PE");
                proj.setCompanyId(c.getCompanyId());
                
                if(userBean.addProject(proj) == false) {
                    out.println("An unexpected error has occured while registering the Project.");
                    errorFound = true;
                }

                if(projFile.getFileName().equals("") == false) {
                    int prjId = userBean.getProject(proj).getProjectId();
                    projFile.setProjectId(prjId);
                    if(userBean.addProjectFile(projFile) == false) {
                        out.println("An unexpected error has occured while registering the Project File.");
                        errorFound = true;
                    }
                }
            }
        }
    }
    else {
        errorFound = true;
        response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
    <title>PRJ566 - Company Home</title>
    <style type="text/css">
        input[type=text], textArea {
            width: 300px;
        }
    </style>
  </head>
  <body>
    <table> 
      <tr>
        <td colspan="2">
          <table width="100%">
            <tr>
              <td width="402" style="background-image: url('../resources/images/header_left.jpg'); background-repeat: no-repeat;">&nbsp;</td>
              <td style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;" width="800">
                <a href="/PRJ666-Implementation/pages/Home.jsp" style="color: black;"><center><h2>WELCOME TO PRJ566<br/> Project Planning and Management</h2></center></a>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr valign="top">
        <td rowspan="5" align="left" width="200"> 
          <img src="../resources/images/seneca_logo.gif" title="Seneca logo"/>
          <br/>
          <img src="../resources/images/ICT_Logo.png" title="ICT Logo"/>
          <br/>
          <%
          if(userBean != null) {
            if(userBean.isLogged() == true) {
              Accounts temp_a = userBean.getLoggedUser();
              out.println("<hr width='95%' align='left'/>");
              Company temp_c = userBean.getCompany();
              out.print("Hello, Company " + temp_c.getCompanyName());
              out.println("<hr width='95%' align='left'/>");
            }
          }
          %>
          <div style="margin:2px; width:200px;">
            <script type="text/javascript"> 
		          new TWTR.Widget( {
  		          version: 2,
  		          type: "profile",
  		          rpp: 5,
 		            interval: 6000,
  		          width: "auto",
  		          height: 300,
  		          theme: {
    		          shell: {
      		          background: "#d5e7e9",
      		          color: "#000000"
    		          },
    		          tweets: {
      		          background: "#fffaff",
     		            color: "#000000",
      		          links: "#0772eb"
    		          }
  		          },	
  		          features: {
    		          scrollbar: false,
    		          loop: false,
    		          live: false,
    		          hashtags: true,
    		          timestamp: true,
    	    	      avatars: false,
    		          behavior: "all"
  		          }
		          } ).render().setUser( "Seneca_College" ).start();
		        </script>
		      </div>
        </td>
        <td style="background-image: url('../resources/images/header_bg.jpg')">
          <ul>
            <li><a href="HomeCompany.jsp">Company Home</a></li>
            <li><a href="ProjectAgreementForm.jsp">Create New Project</a></li>
            <li><a href="ViewCompanyProjects.jsp">Your Projects</a></li>
            <li><a href="ManageCompanyInfo.jsp">Edit Company Info</a></li>
          </ul>
          <div style="float: right;">
            <ul>
              <li><a href="../logout.jsp">Logout</a></li>
            </ul>
          </div>
        </td>
      </tr>
      <tr>
        <td>
        <%
            if(errorFound == false) {
                /*
                out.print(userBean.getLoggedUser().getUserId() + "<br/>");
                out.print(userBean.getLoggedUser().getUserIdentifier() + "<br/>");
                out.print(userBean.getLoggedUser().getAccountStatus() + "<br/>");
                out.print("<hr/>");
                Company c = userBean.getCompany();
                if(c != null) {
                    out.print(c.getCompanyId() + "<br/>");
                    out.print(c.getCompanyName() + "<br/>");
                    out.print(c.getCompanyPhone() + "<br/>");
                    out.print(c.getUserId() + "<br/>");
                }
                out.print("<hr/>");
                out.print(proj.getProjectId() + "<br/>");
                out.print(proj.getStatus() + "<br/>");
                out.print(proj.getPrjName() + "<br/>");
                out.print(proj.getDescription() + "<br/>");
                out.print(proj.getPrjConstraints() + "<br/>");
                out.print(proj.getAgreementDate() + "<br/>");
                out.print(proj.getCompanyId() + "<br/>");
                out.print(proj.getTeamId() + "<br/>");
                out.print(proj.getInstructorId() + "<br/>");
                out.print("<hr/>");
                out.print(projFile.getFileId() + "<br/>");
                out.print(projFile.getFileName() + "<br/>");
                out.print(projFile.getFileDescription() + "<br/>");
                out.print(projFile.getTheFile() + "<br/>");
                out.print(projFile.getProjectId() + "<br/>");
                */
                out.println("<h1>Project Proposal has been successfully registered!</h1>");
                //session.removeAttribute("Project");
                //session.removeAttribute("ProjectFile");
            }
        %>
        </td>
      </tr>             
    </table>
  </body>
</html>
