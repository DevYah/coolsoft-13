$(document).ready(function () {
  $(".scrollshow").hide();
  $(".scrollshowbadge").hide();
  $(window).scroll(function() {
    if ($(this).scrollTop() > 100) {
        $(".scrollshowbadge").slideDown("fast");
    } else {
        $(".scrollshowbadge").slideUp("fast");
    }
    if ($(this).scrollTop() > 650) {
        $(".scrollshow").slideDown("fast");
    } else {
        $(".scrollshow").slideUp("fast");
    }
  });
});