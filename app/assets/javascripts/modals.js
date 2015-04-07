$(document).ready(function() {
  $('#login-tab').click(function (e) {
    console.log(this);
    e.preventDefault();
    console.log($(this).tab('show'));
  })

  $('#signup-tab').click(function (e) {
    console.log(this);
    e.preventDefault();
    console.log($(this).tab('show'));
  })
});
