<%-- 
    Document   : ProjectForm
    Created on : Feb 20, 2012, 5:23:50 PM
    Author     : KepneR
--%>

<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="seneca.projectManagement.entity.*" %>
<%@page import="seneca.projectManagement.utils.*" %>
<%
    if(userBean.isLogged() == true) {
        if(userBean.getLoggedUser().getUserRole().equals("CR") == false) {
            session.setAttribute("Error", "You don't have permission to access the company page.");
            response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
        } else if(session.getAttribute("agreed") == null) {
            session.setAttribute("AgreementError", "You have not agreed to the agreement form.");
            response.sendRedirect("ProjectAgreementForm.jsp");
        }
    } else {
        response.sendRedirect("/PRJ666-Implementation/pages/login.jsp");
    }
    
    Projects proj = new Projects();
    proj.setPrjName("");
    proj.setDescription("");
    proj.setPrjConstraints("");
    if(session.getAttribute("Project") != null) {
        proj = (Projects) session.getAttribute("Project");
    }
    
    Projectfile projFile = new Projectfile();
    projFile.setFileName("");
    projFile.setFileDescription("");
    projFile.setTheFile("");
    if(session.getAttribute("ProjectFile") != null) {
        projFile = (Projectfile) session.getAttribute("ProjectFile");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <link rel="stylesheet" type="text/css" href="../resources/css/jquery-ui-1.8.16.custom.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
    <script type="text/javascript" src="../resources/js/jquery-ui.js"></script>
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
              <td style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;" width="800"><center><h2>WELCOME TO PRJ566<br/> Project Planning and Management</h2></center></td>
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
            <li><a href="#">Current Semester Teams</a></li>
            <li><a href="ProjectAgreementForm.jsp">Create New Project</a></li>
            <li><a href="ViewCompanyProjects.jsp">Your Projects</a></li>
            <li><a href="#">Upcoming Milestones</a></li>
            <li><a href="#">Edit Company Info</a></li>
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
            <h1>Project Proposal Form</h1>
            <form method="POST" action="ProjectRegister.jsp">
                <div style="width: 700px; background-color: #D5E7E9; padding: 5px;">
                    Project Proposal Information 
                </div>
                <div style="width: 700px; padding: 5px">
                    <div style="float: left; width: 150px">Project Name:</div>
                    <div style="float: left"><input type="text" name="id_pname" value="<% out.print(proj.getPrjName()); %>"></div>
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
                    <div style="float: left"><textarea name="id_pcons" cols="40" rows="5"><% out.print(proj.getPrjConstraints()); %></textarea></div>
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
                <div style="width: 700px; background-color: #D5E7E9; padding: 5px;">
                    Project Files and Links Information
                </div>
                <div style="width: 700px; padding: 5px">
                    <div style="float: left; width: 150px">File Name:</div>
                    <div style="float: left"><input type="text" name="id_flname" value="<% out.print(projFile.getFileName()); %>"></div>
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
                    <div style="float: left"><textarea name="id_fldesc" cols="40" rows="5"><% out.print(projFile.getFileDescription()); %></textarea></div>
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
                    <div style="float: left"><input type="text" name="id_fllink" value="<% out.print(projFile.getTheFile()); %>"></div>
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
                <div style="width: 700px; background-color: #D5E7E9; padding: 5px; text-align: right">
                    <input type="submit" value="Continue">
                </div>
            </form>
        </td>
      </tr>             
    </table>
  </body>
</html>
