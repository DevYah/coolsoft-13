$(document).ready(function () {
  $(".scrollshow").hide();
  $(window).scroll(function() {
    if ($(this).scrollTop() > 500) {
        $(".scrollshow").slideDown("fast");
    } else {
        $(".scrollshow").slideUp("fast");
    }
  });
});