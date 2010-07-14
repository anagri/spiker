// Use this file to require common dependencies or to setup useful test functions.
function fixture(element) {
  $('<div id="fixtures"/>').append(element).appendTo("body");
}

function teardownFixtures() {
  $("#fixtures").remove();
}
