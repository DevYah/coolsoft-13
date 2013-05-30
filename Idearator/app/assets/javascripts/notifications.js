function add_notification_event_handlers() {
  notification_click('div.invite-committee-notification', '/redirect_expertise');
  notification_click('div.approve-committee-notification', '/redirect_review');
  notification_click('div.idea-notification', '/redirect_idea');
  notification_click('div.delete-notification', '/set_read');
  notification_click('div.competition-notification', '/redirect_competition');
  notification_click('div.enter_idea-notification', '/redirect_stream');
 
  if($("#notifications").is(":visible")){
    resets_notifications();
  }
}

function resets_notifications(){
  $(".count-no").text("0");
  $(".count-no").removeClass("badge-important");
  $(".count-no").addClass("badge-inverse");
}

$(document).ready(add_notification_event_handlers);

function notification_click(select, redirect){
  $(select).click(function(){
    $(this).removeClass('unread');
    $(this).addClass('read');
    var notification = $(this).data('notification');
    $.getScript(redirect + ".js?&notification=" + notification);
  });
}

$(document).ready(function(){
  $('#count').click(function(){
    val = $('#count').text();
    if(val != 0)
      $.getScript('/set_old');
  });
});
