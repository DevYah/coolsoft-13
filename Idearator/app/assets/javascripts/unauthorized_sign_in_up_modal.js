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
  $('.unauth-sign-in').hide();

  $('.unauth-sign-up .switch').click(function () {
    $('.unauth-sign-up').hide("slide", { direction: "right" }, 500);
    setTimeout(show_sign_in, 501);
  });
  $('.unauth-sign-in .switch').click(function () {
    $('.unauth-sign-in').hide("slide", { direction: "right" }, 500);
    setTimeout(show_sign_up, 501);
  });
  $('.post-an-idea').click(function (e) {
    e.preventDefault();
    $('#signedout').modal('show');
  });
});

function show_sign_up(){
  $('.unauth-sign-up').show();
}

function show_sign_in(){
  $('.unauth-sign-in').show();
}