<%-- 
    Document   : processTeam
    Created on : Jan 26, 2012, 8:36:36 PM
    Author     : matthewschranz
--%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@ page
  import="seneca.projectManagement.utils.CryptoUtil,
          seneca.projectManagement.entity.*"
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
  
  Teams team = userBean.getTeam();
  
  
  if (team != null){
    
      Teammember teamMember = userBean.getLeader(team.getTeamId());
      teamMember.setDescription(tlDesc);
      teamMember.setFirstName(tlFName);
      teamMember.setLastName(tlLName);
      teamMember.setEmail(tlEmail);
      
      
      if (userBean.updateMember( teamMember )) {
        for (int i = 0, len = tmFName.length; i < len;){
          teamMember = new Teammember();
        
          teamMember.setDescription(tmDesc[i]);
          teamMember.setEmail(tmEmail[i]);
          teamMember.setTeamId(team.getTeamId());
          teamMember.setFirstName(tmFName[i]);
          teamMember.setLastName(tmLName[i]);
          teamMember.setTeamLeader(0);
          
          if ( userBean.addMember( teamMember ) ){
            i++;
          }
          else {
            session.setAttribute("errors", "Error. Team Member could not be added.");
            response.sendRedirect("../Team/publishTeamPage.jsp");
          }
        }
      }
      else {
        session.setAttribute("errors", "Error. Team Leader could not be updated.");
        response.sendRedirect("../Team/publishTeamPage.jsp");
      }
    
    team.setTeamDescription(teamDesc);
    team.setTeamConstraints(teamCons);
    team.setTeamName(teamName);
    team.setTeamEmail(emails);
    team.setHasRegistered(1);
    
    if ( userBean.updateTeam( team ) ){
      response.sendRedirect("../Team/teamHome.jsp");
    }
    else {
      session.setAttribute("errors", "Error. Team Account could not be updated.");
      response.sendRedirect("../Team/publishTeamPage.jsp");
    }
  }
  else {
    session.setAttribute("errors", "Error. Team Account could not be found.");
    response.sendRedirect("../Team/publishTeamPage.jsp");
  }
}
else if (request.getParameter("editTeamInfo") != null){
  String tDesc = request.getParameter("tDesc"),
         tLogo = request.getParameter("tLogo"),
         tName = request.getParameter("tName"),
         tCons = request.getParameter("tCons");
  
  Teams t = userBean.getTeam();
  t.setTeamLogo(tLogo);
  t.setTeamConstraints(tCons);
  t.setTeamName(tName);
  t.setTeamDescription(tDesc);
  
  if(!tName.matches("[A-Za-z0-9\\s]{1,20}")){
    session.setAttribute("editTeamFail", "Error. First Name must be only alphanumeric and between 1 and 20 characters in length.");
    session.setAttribute("editTeam", "blahblah");
    response.sendRedirect("../Team/updateTeam.jsp");
  }
  else if(tLogo.isEmpty()){
    session.setAttribute("editTeamFail" , "Error. Image can not be empty.");
    session.setAttribute("editTeam", "blahblah");
    response.sendRedirect("../Team/updateTeam.jsp");
  }
  else if(tDesc.isEmpty() || tDesc.length() > 400){
    session.setAttribute("editTeamFail", "Error. Description can't be empty or greater than 400 characters.");
    session.setAttribute("editTeam", "blahblah");
    response.sendRedirect("../Team/updateTeam.jsp");
  }
  else if(tCons.isEmpty() || tCons.length() > 120){
    session.setAttribute("editTeamFail", "Error. Constraints can't be empty or greater than 120 characters.");
    session.setAttribute("editTeam", "blahblah");
    response.sendRedirect("../Team/updateTeam.jsp");
  }
  else if(!userBean.updateTeam(t)){
    session.setAttribute("editTeamFail", "Error. Team couldn't successfully be saved to the database.");
    session.setAttribute("editTeam", "blahblah");
    response.sendRedirect("../Team/updateTeam.jsp");
  }
  else{
    session.removeAttribute("editTeam");
    session.removeAttribute("editTeamFail");
    session.setAttribute("teamSuccess", "Successfully edited the team info.");
    response.sendRedirect("../Team/manageTeamPage.jsp");
  }    
}
else if (request.getParameter("editMemberInfo") != null) {
  String mDesc = request.getParameter("mDesc"),
         mImage = request.getParameter("mImage"),
         mEmail = request.getParameter("mEmail"),
         mLName = request.getParameter("mLName"),
         mFName = request.getParameter("mFName"),
         mId = request.getParameter("memberId"),
         tEmail = "",
         mLeader = request.getParameter("mLeader");
  
  Teams t = userBean.getTeam();
  Teammember m = new Teammember(), leader = userBean.getLeader(t.getTeamId());
  m.setDescription(mDesc);
  m.setEmail(mEmail);
  m.setFirstName(mFName);
  m.setLastName(mLName);
  m.setMemberImage(mImage);
  m.setMemberId(Integer.parseInt(mId));
  m.setTeamId(t.getTeamId());
  m.setTeamLeader(Integer.parseInt(mLeader));
  
  System.out.println(mLeader);
  
  if(!mFName.matches("[A-Za-z\\s]{3,15}")){
    session.setAttribute("editMemberFail", "Error. First Name must be only alphanumeric and between 3 and 15 characters in length.");
    session.setAttribute("editMember", "blahblah");
    session.setAttribute("mId", mId);
    response.sendRedirect("../Team/updateTeam.jsp");
  }
  else if(!mLName.matches("[A-Za-z\\s]{3,15}")){
    session.setAttribute("editMemberFail", "Error. Last Name must be only alphanumeric and between 3 and 15 characters in length.");
    session.setAttribute("editMember", "blahblah");
    session.setAttribute("mId", mId);
    response.sendRedirect("../Team/updateTeam.jsp");
  }
  else if(!mEmail.matches("[\\w\\+\\-\\._]+(@learn.senecac.on.ca|@senecacollege.ca)")){
    session.setAttribute("editMemberFail", "Error. Email must end in @learn.senecac.on.ca or @senecacollege.ca .");
    session.setAttribute("editMember", "blahblah");
    session.setAttribute("mId", mId);
    response.sendRedirect("../Team/updateTeam.jsp");
  }
  else if(mDesc.isEmpty() || mDesc.length() > 250){
    session.setAttribute("editMemberFail", "Error. Description can't be empty or greater than 250 characters.");
    session.setAttribute("editMember", "blahblah");
    session.setAttribute("mId", mId);
    response.sendRedirect("../Team/updateTeam.jsp");
  }
  else if(leader != null && Integer.parseInt(mLeader) == 1){
    session.setAttribute("editMemberFail", "Error. Can't set multiple members as leader. Please change the leader to a normal member first.");
    session.setAttribute("editMember", "blahblah");
    session.setAttribute("mId", mId);
    response.sendRedirect("../Team/updateTeam.jsp");  
  }
  else if(userBean.updateMember(m)) {
    System.out.println("DERP");
    List<Teammember> members = userBean.getAllMembers(t.getTeamId());
      
    for(int i = 0; i < members.size(); i++){
      m = members.get(i);
      tEmail += m.getEmail() + ";";
    }
      
    t.setTeamEmail(tEmail);
    userBean.updateTeam(t);
    session.removeAttribute("editMember");
    session.removeAttribute("editMemberFail");
    session.setAttribute("teamSuccess", "Successfully edited the info for " + m.getFirstName() + " " + m.getLastName() +".");
    response.sendRedirect("../Team/manageTeamPage.jsp");
  }
  else{
    session.setAttribute("editMemberFail", "Error. Member couldn't successfully be saved to the database.");
    session.setAttribute("editMember", "blahblah");
    response.sendRedirect("../Team/updateTeam.jsp");
  }
}
%>
