$(document).bind("ajaxError", function (e, xhr) {
  if (xhr.status === 401) {
    $('#signedout').modal('show');
  }
});

function add_unauthenticated_event_handlers() {
  $('a.unauthorized-sign-up').click(function () {
    $.getScript("/users/show_sign_in_form.js");
  });
}

$(document).ready(add_unauthenticated_event_handlers);