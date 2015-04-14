$(document).ready(function() {
  $(window).scroll(function() {
    if ($(document).scrollTop() > 100) {
      $('#logo').addClass('shrink');
    }
    else {
      $('#logo').removeClass('shrink');
    }
  });
});
