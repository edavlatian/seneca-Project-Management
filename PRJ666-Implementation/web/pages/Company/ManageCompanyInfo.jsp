<%-- 
    Document   : ManageCompanyInfo
    Created on : Mar 5, 2012, 10:06:25 PM
    Author     : Edouard
--%>

<%@page import="seneca.projectManagement.entity.Company"%>
<%@page import="seneca.projectManagement.entity.Accounts"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<jsp:setProperty name="userBean" property="*" />
<%
    if(userBean.isLogged() == true && userBean != null) {
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
    <link rel="stylesheet" type="text/css" href="../resources/css/pageStuff.css" />
    <script type="text/javascript" src="../resources/js/twitter.js"></script>
    <title>Company Information Management</title>
  </head>
<body>
    <table> 
      <tr>
        <td width="355px"style="background-image: url('../resources/images/header_left.jpg'); background-repeat: no-repeat;">&nbsp;</td>
        <td width="900px" style="background-image: url('../resources/images/header_bg.jpg'); background-repeat: repeat;">
          <a href="/PRJ666-Implementation/pages/Home.jsp" style="color: black;"><center><h2>WELCOME TO PRJ566<br/> Project Planning and Management</h2></center></a>
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
          <div style="margin:2px; width:350px;">
            <script type="text/javascript"> 
		          new TWTR.Widget( {
  		          version: 2,
  		          type: "profile",
  		          rpp: 5,
 		            interval: 6000,
  		          width: 350,
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
        <td style="background-image: url('../resources/images/header_bg.jpg'); height: 1px;">
          <ul>
            <li><a href="/PRJ666-Implementation/pages/Company/HomeCompany.jsp">Company Home</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ProjectAgreementForm.jsp">Create New Project</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ViewCompanyProjects.jsp">Your Projects</a></li>
            <li><a href="/PRJ666-Implementation/pages/Company/ManageCompanyInfo.jsp">Edit Company Info</a></li>
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
            <h1>Please feel free to make any changes below:</h1>
            <%Company company;
              company = userBean.getCompany();
             
            %>
            <strong style="color:red;">
                <%
                    if(request.getParameter("failed")!=null){
                        if(request.getParameter("failed").equals("1")){
                            %>There was an error when saving the changes.<%
                        }
                    }
                    if(request.getParameter("updated")!=null){
                        if(request.getParameter("updated").equals("yes")){
                            %>Changes saved successfully.<%
                        }
                    }              
                %>                               
            </strong>             
            <form method="post" action="../validation/processCompany.jsp">
                <input type="hidden" name="companyId" value="<%=company.getCompanyId()%>" />
                <input type="hidden" name="UpdateCompanyInfo" value="true" />            
                <table>
                    <tr style="vertical-align: top;">
                        <td>Company Name:</br><em style="color: gray; font-size: 12px;">Company Name</em></td>
                        <td><input style="vertical-align: top;" type="text" size="40" name="companyName" value="<%=company.getCompanyName() %>"/></td>
                        <td>
                           <strong style="color:red;">
                                <%
                                    if(request.getParameter("cname")!=null){
                                        if(request.getParameter("cname").equals("1")){
                                            %>Company name field can't be empty!<%
                                        }else if (request.getParameter("cname").equals("2")){
                                            %>Company name can't exceed 25 characters in length!<%
                                        }
                                    }
                                %>                               
                           </strong>
                        </td>
                    </tr>
                    <tr style="vertical-align: top;">
                        <td>Company Description:</br><em style="color: gray; font-size: 12px;">Small history or description <br/>about this company</em></td>
                        <td><textarea rows="3" cols="40" name="companyDescription" style="vertical-align: top;" /><%= company.getCompanyDescription()%></textarea></td>
                        <td>
                            <strong style="color:red;">
                                <%
                                    if(request.getParameter("cdesc")!=null){
                                        if(request.getParameter("cdesc").equals("1")){
                                            %>Description can't be empty!<%
                                        }else if (request.getParameter("cdesc").equals("2")){
                                            %>Description can't exceed 65000 characters in length!<%
                                        }
                                    }
                                %>
                            </strong>
                        </td>
                    </tr>
                    <tr style="vertical-align: top;">
                        <td>Business Areas:</br><em style="color: gray; font-size: 12px;">List or description of <br/>of the areas of business <br />this Company is involved in.</em></td>
                        <td><textarea rows="3" cols="40" name="businessAreas" style="vertical-align: top;" /><%= company.getBusinessAreas()%></textarea></td>
                        <td>
                            <strong style="color:red;">
                                <%
                                    if(request.getParameter("cbusa")!=null){
                                        if(request.getParameter("cbusa").equals("1")){
                                            %>Business Areas can't be empty!<%
                                        }else if (request.getParameter("cbusa").equals("2")){
                                            %>Business Areas can't exceed 65000 characters in length!<%
                                        }
                                    }
                                %>                                
                            </strong>
                        </td>
                    </tr>                    
                    <tr style="vertical-align: top;">
                        <td>Company Phone:</br><em style="color: gray; font-size: 12px;">Contact number <br/>123-555-1234</em></td>
                        <td style="vertical-align: top;"><input type="text" size="40" name="companyPhone" value="<%=company.getCompanyPhone()%>"/></td>
                        <td>
                            <strong style="color:red;">
                                <%
                                    if(request.getParameter("cphon")!=null){
                                        if(request.getParameter("cphon").equals("1")){
                                            %>Phone field can't be empty!<%
                                        }else if (request.getParameter("cphon").equals("2")){
                                            %>Phone can't exceed 12 characters in length!<%
                                        }
                                    }
                                %>                                
                            </strong>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <input type="submit" value="Save Changes" />
                        </td>
                    </tr>
                </table>
            </form>          
        </td>
      </tr>             
    </table>
  </body>
</html>
