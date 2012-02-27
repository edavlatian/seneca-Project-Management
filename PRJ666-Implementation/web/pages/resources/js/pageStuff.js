var memberCount = 0,
    areErrors = true;

function addMember() {
  memberCount++;
  var table = document.getElementById("teamInfo");
      
  table.innerHTML += "<tr>" +
    "<td><b>" + memberCount + ". Team Member First Name:</b> </td>" +
    "<td><input type='text' size='30' name='tmFName' onchange='validateName( this )' /></td>" +
    "</tr>" +
    "<tr>" +
    "<td><b>Team Member Last Name:</b> </td>" +
    "<td><input type='text' size='30' name='tmLName' onchange='validateName( this )' /></td>" +
    "</tr>" +
    "<tr>" +
    "<td><b>Upload Image: </b></td>" +
    "<td><input type='file' name='tmImage' onchange='validateFileSize( this )' accept='image/*'/></td>" +
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

function validateTeamPublish() {
  var errorMessage = document.getElementById("errors");
  
  if (areErrors){
    errorMessage.innerHTML = "Errors still exist on the page.";
    return false;
  }
  
  return true;
};

// Team Functions
function validateTeamName( textControl ) {
  var errorMessage = document.getElementById("errors");
  
  if (textControl.value.length <= 20) {
    errorMessage.innerHTML = "";
    areErrors = false;
  }
  else {
    errorMessage.innerHTML = "Error. Team Name can not be longer than 20 characters.";
    areErrors = true;
  }
};

function validateTeamDescription( textControl ){
  if (textControl.value.length <= 400) {
    errorMessage.innerHTML = "";
    areErrors = false;
  }
  else {
    errorMessage.innerHTML = "Error. Team Description must be under or equal to " +
      "400 characters in length.";
    areErrors = true;
  }
};

function validateTeamConstraints( textControl ){
  if (textControl.value.length <= 120) {
    errorMessage.innerHTML = "";
    areErrors = false;
  }
  else {
    errorMessage.innerHTML = "Error. Team Constraints must be under or equal to " +
      "120 characters in length.";
    areErrors = true;
  }  
};

// Team Member/Leader Functions
function validateEmail( textControl ) {
  var pattern = /^[\w\+\-\._]+(@learn.senecac.on.ca|@senecacollege.ca)$/,
      errors,
      cellNode = textControl.parentNode;
      
  if (pattern.test(textControl.value) && textControl.value.length <= 50) {
    cellNode.removeChild( cellNode.childNodes[ 1 ] );
    areErrors = false;
  }
  else {
    errors = document.createElement( "div" );
    errors.setAttribute( "class", "errors" );
    errors.innerHTML = "Error. Emails must end with @learn.senecac.on.ca " +
      "or @senecacollege.ca and under 50 characters.";
    
    if( !cellNode.childNodes[ 1 ] )
     cellNode.appendChild( errors );
    areErrors = true;
  }
};

function validateName( textControl ) {
  var pattern = /^[A-Za-z\s]{3,15}$/,
      errors,
      cellNode = textControl.parentNode;
  
  if (pattern.test(textControl.value)) {
    cellNode.removeChild( cellNode.childNodes[ 1 ] );
    areErrors = false;
  }
  else {
    errors = document.createElement( "div" );
    errors.setAttribute( "class", "errors" );
    errors.innerHTML = "Error. Names must be under 15 characters and only letters " +
      "or spaces.";
    
    if( !cellNode.childNodes[ 1 ] )
     cellNode.appendChild( errors );
    areErrors = true;
  }
};

function validateMemberDescription( textControl ) {
  if (textControl.value.length <= 250) {
    errorMessage.innerHTML = "";
    areErrors = false;
  }
  else {
    errorMessage.innerHTML = "Error. Member Description must be under or equal to " +
      "250 characters in length.";
    areErrors = true;
  }
};

/* Currently isn't functioning the way I intended */
function validateFileSize( fileControl ) {
  var errors,
      cellNode = fileControl.parentNode;
      
  /*
  if ( fileControl.fileSize <= 512800 ) {
    cellNode.removeChild( cellNode.childNodes[ 1 ] );
    areErrors = false;
  }
  else {
    errors = document.createElement( "div" );
    errors.setAttribute( "class", "errors" );
    errors.innerHTML = "Error. File must be less than or equal to 500kb in size.";
    
    if( !cellNode.childNodes[ 1 ] )
     cellNode.appendChild( errors );
    
    areErrors = true;
  }
  */

  areErrors = false;
};

function displayDetails( aButton ){
  var parentElement = aButton.parentNode,
      details = parentElement.childNodes[ 15 ];
      
  if( aButton.innerHTML === "Show Details" ){
    aButton.innerHTML = "Hide Details";
    details.style.display = "";
  }
  else {
    aButton.innerHTML = "Show Details";
    details.style.display = "none";
  }
  
};