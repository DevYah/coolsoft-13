// Does long polling on Coolsters server.
// Author: Amina Zoheir

function poll() {
  $.ajax({
    url: COOLSTER_URL + '/poll',
    dataType: "script",
    success: function(data, textStatus, jXHR){
      $.ajax(this);
        return;
    },
    error: function(jXHR, textStatus, errorThrown){
        $.ajax(this);
        return;
    },
    timeout: 60000
  });
}

$(function () {
  setTimeout(poll, 1000);
});
