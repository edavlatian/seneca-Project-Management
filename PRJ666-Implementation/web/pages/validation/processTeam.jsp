<%-- 
    Document   : processTeam
    Created on : Jan 26, 2012, 8:36:36 PM
    Author     : matthewschranz
--%>
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
else if ("true".equals(request.getParameter("editTeamPage"))) {
  String[] tmDescs = request.getParameterValues("id_tmDesc"),
           tmImages = request.getParameterValues("id_tmImage"),
           tmEmails = request.getParameterValues("id_tmEmail"),
           tmLNames = request.getParameterValues("id_tmLName"),
           tmFNames = request.getParameterValues("id_tmFName");
  
  String tLogo = request.getParameter("id_tLogo"),
         tCons = request.getParameter("id_tCons"),
         tDesc = request.getParameter("id_tDesc"),
         tName = request.getParameter("id_tName"),
         tlFName = request.getParameter("id_tlFName"),
         tlLName = request.getParameter("id_tlLName"),
         tlEmail = request.getParameter("id_tlEmail"),
         tlImage = request.getParameter("id_tlImage"),
         tlDesc = request.getParameter("id_tlDesc"),
         tEmail;
  
  // Team Validation
  if(tName.isEmpty() || tName.length() > 20){
    session.setAttribute("tName", "Error. Team Name can not be empty or greater than 20 characters.");
    %>
    <jsp:forward page="../Team/editTeamPage.jsp" />
    <%
  }
  else if(tDesc.isEmpty() || tDesc.length() > 400){
    session.setAttribute("tDesc", "Error. Team Description can not be empty or greater than 400 characters.");
    %>
    <jsp:forward page="../Team/editTeamPage.jsp" />
    <%
  }
  else if(tCons.isEmpty() || tCons.length() > 120){
    session.setAttribute("tCons", "Error. Team Constrains can not be empty or greater than 120 characters.");
    %>
    <jsp:forward page="../Team/editTeamPage.jsp" />
    <%
  }
  else if(tLogo.isEmpty()){
    session.setAttribute("tLogo", "Error. Teamd Logo location can not be empty.");
    %>
    <jsp:forward page="../Team/editTeamPage.jsp" />
    <%
  }
  
  // Team Leader Validation
  if(!tlFName.matches("[A-Za-z\\s]{3,15}")){
    session.setAttribute("tlFName", "Error. Must be only alphanumeric and between 3 and 15 characters in length.");
    %>
    <jsp:forward page="../Team/editTeamPage.jsp" />
    <%
  }
  else if(!tlLName.matches("[A-Za-z\\s]{3,15}")){
    session.setAttribute("tlLName", "Error. Must be only alphanumeric and between 3 and 15 characters in length.");
    %>
    <jsp:forward page="../Team/editTeamPage.jsp" />
    <%
  }
  else if(!tlEmail.matches("[\\w\\+\\-\\._]+(@learn.senecac.on.ca|@senecacollege.ca)")){
    session.setAttribute("tlEmail", "Error. Must end with @learn.senecac.on.ca or @senecacollege.ca");
    %>
    <jsp:forward page="../Team/editTeamPage.jsp" />
    <%
  }
  else if(tlImage.isEmpty()){
    session.setAttribute("tlImage", "Error. Team Leader Image can't be empty.");
    %>
    <jsp:forward page="../Team/editTeamPage.jsp" />
    <%
  }
  else if(tlDesc.isEmpty() || tlDesc.length() > 250){
    session.setAttribute("tlDesc", "Error. Can't be empty or greater than 250 characters.");
    %>
    <jsp:forward page="../Team/editTeamPage.jsp" />
    <%
  }

  // Team Member First Name Validation
  Pattern p = Pattern.compile("[A-Za-z\\s]{3,15}");
  Matcher m;
  
  for(int i = 0, len = tmFNames.length; i < len; i++){
    m = p.matcher(tmFNames[i].toString());
    if(!m.matches()){
      session.setAttribute("tmFName" + i, "Error. Must be only alphanumeric and between 3 and 15 characters in length.");
    %>
    <jsp:forward page="../Team/editTeamPage.jsp" />
    <%
    }
  }
  
  // Team Member Last Name Validation
  for(int i = 0, len = tmLNames.length; i < len; i++){
    m = p.matcher(tmLNames[i].toString());
    if(!m.matches()){
      session.setAttribute("tmLName" + i, "Error. Must be only alphanumeric and between 3 and 15 characters in length.");
    %>
    <jsp:forward page="../Team/editTeamPage.jsp" />
    <%
    }
  }
  
  // Team Member Email Validation
  p = Pattern.compile("[\\w\\+\\-\\._]+(@learn.senecac.on.ca|@senecacollege.ca)");
  for(int i = 0, len = tmEmails.length; i < len; i++){
    m = p.matcher(tmEmails[i].toString());
    if(!m.matches()){
      session.setAttribute("tmEmail" + i, "Error. Email must end in @learn.senecac.on.ca or @senecacollege.ca .");
    %>
    <jsp:forward page="../Team/editTeamPage.jsp" />
    <%
    }
  }
  
  // Team Member Images Validation
  for(int i = 0, len = tmImages.length; i < len && tmImages[i] != null; i++){
    System.out.println("in for loop");
    if(tmImages[i].isEmpty()){
      session.setAttribute("tmImages" + i, "Error. Must not be empty.");
    %>
    <jsp:forward page="../Team/editTeamPage.jsp" />
    <%
    }
  }

  // Team Member Desc Validation
  for(int i = 0, len = tmDescs.length; i < len; i++){
    if(tmDescs[i].isEmpty() || tmDescs[i].length() > 250){
      session.setAttribute("tmDesc" + i, "Error. Can't be empty or greater than 250 characters.");
      %>
      <jsp:forward page="../Team/editTeamPage.jsp" />
      <%
    }
  }
  
  tEmail = tlEmail + ";";
  for(int k = 0, len = tmEmails.length; k < len; k++){
    tEmail += (tmEmails[k] + ";");
  }
  
  Teams team = userBean.getTeam();
  List<Teammember> members = userBean.getAllTeamMembers( team.getTeamId() );
  team.setTeamConstraints(tCons);
  team.setTeamDescription(tDesc);
  team.setTeamEmail(tEmail);
  team.setTeamLogo(tLogo);
  team.setTeamName(tName);
  
  if(userBean.updateTeam(team)){
    System.out.println("Updated the team");
    Teammember leader = userBean.getLeader(team.getTeamId());
    leader.setDescription(tlDesc);
    leader.setFirstName(tlFName);
    leader.setLastName(tlLName);
    leader.setMemberImage(tlImage);
    leader.setEmail(tlEmail);
    
    if(userBean.updateMember(leader)){
      System.out.println("Updated the leader");
      
      for(int i = 0, len = tmFNames.length; i < len; i++){
        leader = members.get(i);
        
        leader.setFirstName(tmFNames[i]);
        leader.setLastName(tmLNames[i]);
        leader.setDescription(tmDescs[i]);
        leader.setEmail(tmEmails[i]);
        leader.setMemberImage(tmImages[i]);
        
        if(!userBean.updateMember(leader)){
          session.setAttribute("errors", "Error. Failed to update a team member.");
          %>
          <jsp:forward page="../Team/editTeamPage.jsp" />
          <%
        }
      }
      session.setAttribute("editSuccess", "You successfully updated your Team Page! WOOOOHOOOOO!");
      %>
      <jsp:forward page="../Team/teamHome.jsp" />
      <%
    }
    else {
      session.setAttribute("errors", "Error. Failed to update the Team Leader.");
      %>
      <jsp:forward page="../Team/editTeamPage.jsp" />
      <%
    }
  }
  else {
    session.setAttribute("errors", "Error. Failed to update the team.");
    %>
    <jsp:forward page="../Team/editTeamPage.jsp" />
    <%
  }
}
else if("true".equals(request.getParameter("createMilestone"))){
  String mName = request.getParameter("milestoneName"),
         mDesc = request.getParameter("milestoneDescription"),
         mStatus = request.getParameter("milestoneStatus"),
         mDate = request.getParameter("milestoneDate");
  
  if(!mName.matches("[A-Za-z\\s]{7,70}")){
    session.setAttribute("createErrors", "Error. Milestone name must be between 7 and 70 alphanumeric characters.");
    %>
    <jsp:forward page="../Team/createMilestone.jsp" />
    <%  
  }
  else if(!mDesc.matches("[A-Za-z\\s.]{10,125}")){
    session.setAttribute("createErrors", "Error. Milestone description must be between 10 and 125 alphanumeric characters.");
    %>
    <jsp:forward page="../Team/createMilestone.jsp" />
    <% 
  }
  DateFormat f = new SimpleDateFormat("MM/dd/yyyy");
  Date d = (Date) f.parse(mDate);
  
  // Date Validation
  if(d.before(new Date())){
    session.setAttribute("createErrors", "Error. Milestone date can't be set to the past.");
    %>
    <jsp:forward page="../Team/createMilestone.jsp" />
    <%  
  }
  
  Teams team = userBean.getTeam();
  Projects proj = userBean.getTeamProject(team.getTeamId());
  
  Milestone milestone = new Milestone();
  milestone.setDescription(mDesc);
  milestone.setDueDate(d);
  milestone.setMilestoneName(mName);
  milestone.setMilestoneStatus(mStatus);
  milestone.setProjectId(proj.getProjectId());
  
  if(!userBean.newMilestone(milestone))
    session.setAttribute("createErrors", "Error. Milestone was not successfully added.");
  else {
    session.setAttribute("createSuccess", "Milestone Successfully Added.");
  }
  
  response.sendRedirect("../Team/createMilestone.jsp");
}
else if("true".equals(request.getParameter("editMilestone"))){
  String[] mName = request.getParameterValues("milestoneName"),
           mDesc = request.getParameterValues("milestoneDescription"),
           mDate = request.getParameterValues("milestoneDate"),
           mStatus = request.getParameterValues("milestoneStatus"),
           mId = request.getParameterValues("milestoneId");
  
  // Name Validation
  for( int i = 0, len = mName.length; i < len; i++ ){
    if(!mName[i].matches("[A-Za-z\\s]{7,70}")){
      session.setAttribute("editErrors" + i, "Error. Milestone name must be between 7 and 70 alphanumeric characters.");
      %>
      <jsp:forward page="../Team/editMilestone.jsp" />
      <%  
    }
  }
  
  // Description Validation
  for( int i = 0, len = mDesc.length; i < len; i++ ){
    if(!mDesc[i].matches("[A-Za-z\\s.]{10,125}")){
      session.setAttribute("editErrors" + i, "Error. Milestone description must be between 10 and 125 alphanumeric characters.");
      %>
      <jsp:forward page="../Team/editMilestone.jsp" />
      <% 
    }
  }
  
  DateFormat f = new SimpleDateFormat("MM/dd/yyyy");;
  Date d;
  
  // Date Validation
  for( int i = 0, len = mDate.length; i < len; i++ ){
   d = (Date) f.parse(mDate[i]);
  
    // Date Validation
    if(d.before(new Date())){
      session.setAttribute("editErrors" + i, "Error. Milestone date can't be set to the past.");
      %>
      <jsp:forward page="../Team/editMilestone.jsp" />
      <%  
    } 
  }
  
  Milestone m;
  Teams team = userBean.getTeam();
  Projects proj = userBean.getTeamProject(team.getTeamId());
  for( int i = 0, len = mName.length; i < len; ){
    m = new Milestone();
    m.setDescription(mDesc[i]);
    m.setDueDate((Date) f.parse(mDate[i]));
    m.setMilestoneId(Integer.parseInt(mId[i]));
    m.setMilestoneStatus(mStatus[i]);
    m.setMilestoneName(mName[i]);
    m.setProjectId(proj.getProjectId());
    
    if(userBean.updateMilestone(m))
      i++;
    else {
      session.setAttribute("editErrors" + i, "Error. Milestone couldn't be updated.");
      %>
      <jsp:forward page="../Team/editMilestone.jsp" />
      <%
    }   
  }
  
  session.setAttribute("editSuccess", "Milestones successfully edited.");
  %>
  <jsp:forward page="../Team/editMilestone.jsp" />
  <%  
}
else if("true".equals(request.getParameter("teamRanking"))){
  String[] rankings = request.getParameterValues("pRank"),
           pIds = request.getParameterValues("pId"), numUsed;
  
  int rankCount = 0;
  
  Calendar cal = Calendar.getInstance();
  String s;
  switch(cal.get(Calendar.MONTH)){
    case 0:
    case 1:
    case 2:
    case 3:
      s = "Win" + cal.get(Calendar.YEAR);
      break;
    case 4:
    case 5:
    case 6:
    case 7:
      s = "Sum" + cal.get(Calendar.YEAR);
      break;
    case 8:
    case 9:
    case 10:
    case 11:
    default:
      s = "Fall" + cal.get(Calendar.YEAR);
  }
  
  int teamCount = userBean.countSemesterTeams(s);
  
  for(int i = 0, len = rankings.length; i < len; i++){
    if(!rankings[i].isEmpty())
      rankCount++;
  }
    
  if(rankCount < teamCount && rankCount > 0){
    session.setAttribute("rankFailed", "Error. Can not rank less projects than there are teams this semester.");
    %>
    <jsp:forward page="../Team/rankProjects.jsp" />
    <%
  }
  else if(teamCount > pIds.length && rankCount < pIds.length){
    session.setAttribute("rankFailed", "Error. Must rank all projects when there are more teams than projects.");
    %>
    <jsp:forward page="../Team/rankProjects.jsp" />
    <%
  }
  else if(rankCount == 0){
    session.setAttribute("rankFailed", "Error. Can not rank no projects.");
    %>
    <jsp:forward page="../Team/rankProjects.jsp" />
    <%
  }
  
  numUsed = new String[rankCount];
  boolean found = false;
  for(int i = 0, len = rankCount; i < len;){
    for(int k = 0, len2 = numUsed.length; k < len2 || found;){
      if(numUsed[k] != null && numUsed[k].equals(rankings[i]))
        found = true;
      else
        k++;
    }
    if(found){
      session.setAttribute("rankFailed", "Error. Can not use the same rank twice.");
      %>
      <jsp:forward page="../Team/rankProjects.jsp" />
      <% 
    }
    else{
      numUsed[i] = rankings[i];
      i++;  
    }
  }
  
  for(int i = 0; i < numUsed.length; i++)
    out.println(numUsed[i]);
}
%>
