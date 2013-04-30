$(document).bind("ajaxError", function (e, xhr) {
  if (xhr.status === 401) {
    $('#signedout').modal('show');
  }
});

$(document).ready(function () {
  $('#unauth-sign-in-button').click(function () {
    var newValue = { opacity : 100 }
    $('.unauth-huge').addClass('unauth-right', 500);
  });
  $('#unauth-sign-up-button').click(function () {
    var newValue = { opacity : 100 }
    $('.unauth-huge').removeClass('unauth-right', 500);
  });
}