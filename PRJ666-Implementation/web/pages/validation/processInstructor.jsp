<%-- 
    Document   : processInstructor
    Created on : Jan 26, 2012, 8:37:01 PM
    Author     : matthewschranz
--%>

<%@page import="java.util.Calendar"%>
<%@ page
  import="seneca.projectManagement.utils.CryptoUtil,
          seneca.projectManagement.entity.*"
  language="java" contentType="text/html; charset=ISO-8859-1"
  pageEncoding="ISO-8859-1"%>
  
  <jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession"
               scope="session" />
  <jsp:setProperty name="userBean" property="*" />
<% 
if(request.getParameter("matchTeam") != null){
  String pId = request.getParameter("selectedProject"),
         tId = request.getParameter("teamId");
  
  if(pId.equals("0")){
    session.setAttribute("matchFail", "Error. Must select a project to match.");
    session.setAttribute("Team", tId);
    response.sendRedirect("../Instructor/matchTeam.jsp");
  }
  else {
    Teams t = userBean.getTeam(Integer.parseInt(tId));
    Projects p = userBean.getProject(Integer.parseInt(pId));
    
    t.setProjectId(p.getProjectId());
    if(userBean.updateTeam(t)){
      p.setStatus("MA");
      p.setInstructorId(userBean.getLoggedUser().getUserId());
      p.setTeamId(t.getTeamId());
      
      Calendar cal = Calendar.getInstance();
      String value = null;
      switch(cal.get(Calendar.MONTH)) {
        case 0:
        case 1:
        case 2:
        case 3:
          value = "PRJ566WIN" + cal.get(Calendar.YEAR);
          break;
        case 4:
        case 5:
        case 6:
        case 7:
          value = "PRJ566SUM" + cal.get(Calendar.YEAR);
          break;
        case 8:
        case 9:
        case 10:
        case 11:
          value = "PRJ566FALL" + cal.get(Calendar.YEAR);
          break;
      }
      
      p.setPrjIdentifier(value);
      if(userBean.updateProject(p)){
        session.setAttribute("matchSuccess", "Matched Team " + t.getTeamName() + " with " + p.getPrjName() + " successfully.");
        session.removeAttribute("Team");
        response.sendRedirect("../Instructor/matching.jsp");
      }
      else {
        session.setAttribute("Error", "Error. Failed to update the projects information. Please manually change it.");
        session.removeAttribute("Team");
        response.sendRedirect("../Instructor/matching.jsp");
      }
    }
    else {
      session.setAttribute("Error", "Error. Failed to update the teams information. Please manually change it.");
      session.removeAttribute("Team");
      response.sendRedirect("../Instructor/matching.jsp");
    }
  }
}
else if(request.getParameter("createTeamMember") != null){
  String tId = request.getParameter("mTeam"),
         mFName = request.getParameter("mFName"),
         mLName = request.getParameter("mLName"),
         mEmail = request.getParameter("mEmail");
  
  if(tId.endsWith("0")){
    session.setAttribute("createMemberFail", "Error. Must select a team to place the new member with.");
    session.setAttribute("createMember", "blahblah");
    request.getRequestDispatcher("../Instructor/updateMembers.jsp").forward(request, response);
  }
  else if(!mFName.matches("[A-Za-z\\s]{3,15}")){
    session.setAttribute("createMemberFail", "Error. First Name must be only alphanumeric and between 3 and 15 characters in length.");
    session.setAttribute("createMember", "blahblah");
    request.getRequestDispatcher("../Instructor/updateMembers.jsp").forward(request, response);
  }
  else if(!mLName.matches("[A-Za-z\\s]{3,15}")){
    session.setAttribute("createMemberFail", "Error. Last Name must be only alphanumeric and between 3 and 15 characters in length.");
    session.setAttribute("createMember", "blahblah");
    request.getRequestDispatcher("../Instructor/updateMembers.jsp").forward(request, response);
  }
  else if(!mEmail.matches("[\\w\\+\\-\\._]+(@learn.senecac.on.ca|@senecacollege.ca)")){
    session.setAttribute("createMemberFail", "Error. Email must end in @learn.senecac.on.ca or @senecacollege.ca .");
    session.setAttribute("createMember", "blahblah");
    request.getRequestDispatcher("../Instructor/updateMembers.jsp").forward(request, response);
  }
  else{
    Teammember m = new Teammember();
    m.setFirstName(mFName);
    m.setLastName(mLName);
    m.setEmail(mEmail);
    m.setTeamId(new Integer(tId));
    
    if(userBean.addMember(m)){
      Teams t = userBean.getTeamById(new Integer(tId));
      session.removeAttribute("createMember");
      session.setAttribute("memberSuccess", "Successfully added " + mFName + " " + mLName + " to " + t.getTeamName() + ".");
      response.sendRedirect("../Instructor/manageTeamMembers.jsp");
    }
    else {
      session.setAttribute("Error", "Error. Couldn't add member to team. Please try manually.");
      session.removeAttribute("createMember");
      response.sendRedirect("../Instructor/manageTeamMembers.jsp");       
    }
  }
}
%>
