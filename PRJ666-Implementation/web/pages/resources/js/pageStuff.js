var memberCount = 0;
function addMember() {
  memberCount++;
  var table = document.getElementById("teamInfo");
          
  table.innerHTML += "<tr>" +
  "<td><b>" + memberCount + ". Team Member Name:</b> </td>" +
  "<td><input type='text' size='30' name='tmName'/></td>" +
  "</tr>" +
  "<tr>" +
  "<td>Upload Image: </td>" +
  "<td><input type='file' name='tmImage' size='40'/></td>" +
  "</tr>" +
  "<tr>" +
  "<td>Short Story: </td>" +
  "<td><textarea rows='3' cols='40' name='tmShortStory'></textarea></td>" +
  "</tr>" +
  "<tr>" +
  "<td>E-mail Address: </td>" +
  "<td><input type='text' size='40' name='tmEmail'/></td>" +
  "</tr>";
};