$(document).bind("ajaxError", function (e, xhr) {
  if (xhr.status === 401) {
    $('#signedout').modal('show');
  }
});

function add_unauthenticated_event_handlers() {
  $('a.unauthorized-sign-up').click(function () {
    $.getScript("/redirect_expertise.js?&notification=" + notification);
  });
}

$(document).ready(add_notification_event_handlers);