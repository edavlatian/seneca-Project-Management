<%-- 
    Document   : processTeam
    Created on : Jan 26, 2012, 8:36:36 PM
    Author     : matthewschranz
--%>

<%@ page
  import="seneca.projectManagement.utils.CryptoUtil,
          seneca.projectManagement.databaseClasses.Teams,
          seneca.projectManagement.databaseClasses.Teammember"
  language="java" contentType="text/html; charset=ISO-8859-1"
  pageEncoding="ISO-8859-1"%>
  
  <jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession"
               scope="session" />
  <jsp:setProperty name="userBean" property="*" />
  
<%
if ("true".equals(request.getParameter("publishTeamPage"))){
  // Team Members
  String[] tmFName = request.getParameterValues("tmFName"),
           tmLName = request.getParameterValues("tmLName"),
           tmDesc = request.getParameterValues("tmDesc"),
           tmEmail = request.getParameterValues("tmEmail");
  
  // Team Leader 
  String tlFName = request.getParameter("tlFName"),
         tlLName = request.getParameter("tlLName"),
         tlDesc = request.getParameter("tlDesc"),
         tlEmail = request.getParameter("tlEmail");
  
  // Team Fields
  String teamDesc = request.getParameter("teamDescription"),
         teamCons = request.getParameter("teamConstraints"),
         teamName = request.getParameter("teamName");

  String emails = "";
  emails = tlEmail + ";";
  
  for(int i = 0, len = tmEmail.length; i < len; i++){
    emails += tmEmail[i] + ";";
  }
  
  Teams team = userBean.getTeamAccount(userBean.getLoggedUser().getUserid());
  
  
  if (team != null){
    
      Teammember teamMember = userBean.getTeamLeader(team.getTeamid());
      teamMember.setDescription(tlDesc);
      teamMember.setFirstname(tlFName);
      teamMember.setLastname(tlLName);
      teamMember.setEmail(tlEmail);
      
      
      if (userBean.updateTeamMember(teamMember) == 1) {
        for (int i = 0, len = tmFName.length; i < len;){
          teamMember = new Teammember();
        
          teamMember.setDescription(tmDesc[i]);
          teamMember.setEmail(tmEmail[i]);
          teamMember.setTeamid(team.getTeamid());
          teamMember.setFirstname(tmFName[i]);
          teamMember.setLastname(tmLName[i]);
          teamMember.setTeamleader(0);
          
          if (userBean.addTeamMember(teamMember))
            i++;
          else {
            request.setAttribute("errors", "Error. Team Member could not be added.");
            request.getRequestDispatcher("../Team/publishTeamPage.jsp").forward(request, response);
          }
        }
      }
      else {
        request.setAttribute("errors", "Error. Team Leader could not be updated.");
        request.getRequestDispatcher("../Team/publishTeamPage.jsp").forward(request, response);
      }
    
    team.setTeamDescription(teamDesc);
    team.setTeamconstraints(teamCons);
    team.setTeamname(teamName);
    team.setTeamemail(emails);
    
    if (userBean.updateTeamAccount(team) == 1){
      request.getRequestDispatcher("../Team/teamHome.jsp").forward(request, response);
    }
    else {
      request.setAttribute("errors", "Error. Team Account could not be updated.");
      request.getRequestDispatcher("../Team/publishTeamPage.jsp").forward(request, response);
    }
  }
  else {
    request.setAttribute("errors", "Error. Team Account could not be found.");
    request.getRequestDispatcher("../Team/publishTeamPage.jsp").forward(request, response);
  }
}
%>
