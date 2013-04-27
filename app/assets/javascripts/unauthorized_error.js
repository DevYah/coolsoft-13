$(document).bind("ajaxError", function (e, xhr) {
  if (xhr.status === 401) {
    $('#signedout').modal('show');
  }
});