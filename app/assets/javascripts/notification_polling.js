// initiates the polling if there is a signed in user.
// Params: none
// Author: Amina Zoheir
$(function() {
  if($('body').attr('data-devise') == "true"){
    setTimeout(updateNotifications, 5000);
  }
});

// updates the notifications in navigation bar and in all notifications view,
// and continues the polling.
// Params: none
// Author: Amina Zoheir
function updateNotifications(){
  if($("#notifications").length > 0){
    var after = $('.notification:first').attr('data-time');
    $.getScript("/view_new_notifications.js?&after=" + after);
  }
  $.getScript("/notifications.js")
  setTimeout(updateNotifications, 5000);
}