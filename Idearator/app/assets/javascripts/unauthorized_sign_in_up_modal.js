// Show sign in/up modal dialog on ajax unauthorized error
// Author: Amina Zoheir
$(document).bind("ajaxError", function (e, xhr) {
  if (xhr.status === 401) {
    $('#signedout').modal('show');
  }
});

// Adds event handler on click for sign in and sign up buttons to show their forms
// Author: Amina Zoheir
$(document).ready(function() {
  var w = $('#signedout').outerWidth();
  $('#signedout').css({'margin-left':-Math.round(w/2) + 30})
  $('.unauth-sign-in').hide();

  $('.unauth-centered .unauth-sign-up .switch').click(function () {
    $('.unauth-centered .unauth-sign-up').hide();
    $('.unauth-centered .unauth-sign-in').fadeIn('slow');
  });
  $('.unauth-centered .unauth-sign-in .switch').click(function () {
    $('.unauth-centered .unauth-sign-in').hide();
    $('.unauth-centered .unauth-sign-up').fadeIn('slow');
  });

  $('.landing-centered .unauth-sign-up .switch').click(function () {
    $('.landing-centered .unauth-sign-up').hide();
    $('.landing-centered .unauth-sign-in').fadeIn('slow');
  });
  $('.landing-centered .unauth-sign-in .switch').click(function () {
    $('.landing-centered .unauth-sign-in').hide();
    $('.landing-centered .unauth-sign-up').fadeIn('slow');
  });

  $('.post-an-idea').click(function (e) {
    e.preventDefault();
    $('#signedout').modal('show');
  });
});