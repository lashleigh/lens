jQuery(function() {
  $("#do_user_search").click(parseUsers);
})

function parseUsers() {
  var users = document.getElementById("queryInput").value.split(',');
  $.get("/home/show", { names : users });
  console.log(users);
  console.log(users[0]);
}
