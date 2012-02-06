var memberCount = 0,
    numErrors = 0;

function addMember() {
  memberCount++;
  var table = document.getElementById("teamInfo");
          
  table.innerHTML += "<tr>" +
  "<td><b>" + memberCount + ". Team Member First Name:</b> </td>" +
  "<td><input type='text' size='30' name='tmFirstName' onchange='validateName( this )' /></td>" +
  "</tr>" +
  "<tr>" +
  "<td><b>Team Member Last Name:</b> </td>" +
  "<td><input type='text' size='30' name='tmLastName' onchange='validateName( this )' /></td>" +
  "</tr>" +
  "<tr>" +
  "<td><b>Upload Image: </b></td>" +
  "<td><input type='file' name='tmImage' size='40'/></td>" +
  "</tr>" +
  "<tr>" +
  "<td><b>Member Description: </b></td>" +
  "<td><textarea rows='3' cols='40' name='tmDesc' onchange='validateMemberDescription( this )' " +
  "></textarea></td>" +
  "</tr>" +
  "<tr>" +
  "<td><b>E-mail Address: </b></td>" +
  "<td><input type='text' size='40' name='tmEmail' onchange='validateEmail( this )'/></td>" +
  "</tr>" +
  "<tr>" +
  "<td colspan='2'><hr/></td>" +
  "</tr>";
};

function validatePublish() {
  var errorMessage = document.getElementById("errors");
  
  if (numErrors === 0)
    return true;
  
  if (numErrors !== 0 && errorMessage.innerHTML === "")
    errorMessage.innerHTML = "Error. NumErrors was not zero. Re check all elements.";
  
  return false;
};

// Team Functions
function validateTeamName( textControl ) {
  var errorMessage = document.getElementById("errors");
  
  if (textControl.value.length <= 20) {
    numErrors -= 1;
    errorMessage.innerHTML = "";
  }
  else {
    errorMessage.innerHTML = "Error. Team Name can not be longer than 20 characters.";
    numErrors++;
  }
};

function validateTeamDescription( textControl ){
  if (textControl.value.length <= 400) {
    numErrors -= 1;
    errorMessage.innerHTML = "";
  }
  else {
    errorMessage.innerHTML = "Error. Team Description must be under or equal to " +
      "400 characters in length.";
    numErrors++;
  }
};

function validateTeamConstraints( textControl ){
  if (textControl.value.length <= 120) {
    numErrors -= 1;
    errorMessage.innerHTML = "";
  }
  else {
    errorMessage.innerHTML = "Error. Team Constraints must be under or equal to " +
      "120 characters in length.";
    numErrors++;
  }  
};

// Team Member/Leader Functions
function validateEmail( textControl ) {
  var errorMessage = document.getElementById("errors"),
      pattern = /^[\w\+\-\._]+(@learn.senecac.on.ca|@senecacollege.ca)$/;
  if (pattern.test(textControl.value) && textControl.value.length <= 50) {
    numErrors -= 1;
    errorMessage.innerHTML = "";
  }
  else {
    errorMessage.innerHTML = "Error. Emails must end with @learn.senecac.on.ca " +
      "or @senecacollege.ca and under 50 characters.";
    numErrors++;
  }
};

function validateName( textControl ) {
  var errorMessage = document.getElementById("errors"),
  pattern = /^[A-Za-z\s]{3,15}$/;
  
  if (pattern.test(textControl.value)) {
    numErrors -= 1;
    errorMessage.innerHTML = "";
  }
  else {
    errorMessage.innerHTML = "Error. Names must be under 15 characters and only letters "
      "or spaces.";
    numErrors++;
  }
};

function validateMemberDescription( textControl ) {
  if (textControl.value.length <= 250) {
    numErrors -= 1;
    errorMessage.innerHTML = "";
  }
  else {
    errorMessage.innerHTML = "Error. Member Description must be under or equal to " +
      "250 characters in length.";
    numErrors++;
  }
};