function add_notification_event_handlers() {
  notification_click('div.invite-committee-notification', '/redirect_expertise');
  notification_click('div.approve-committee-notification', '/redirect_review');
  notification_click('div.idea-notification', '/redirect_idea');
  notification_click('div.delete-notification', '/set_read');
  notification_click('div.competition-notification', '/redirect_competition');
  notification_click('div.enter_idea-notification', '/redirect_stream')
}

$(document).ready(add_notification_event_handlers);

function notification_click(select, redirect){
  $(select).click(function(){
    if(select == 'div.delete-notification'){
      $(this).removeClass('unread');
      $(this).addClass('read');
      var count = $(this).data('count');
      if(count > 0){
        $('#count').html('<span id="count-badge" class="badge badge-important">' + count + '</span><b class="caret"></b>');
      }else{
        $('#count').html('<span id="count-badge" class="badge badge-inverse">' + count + '</span><b class="caret"></b>');
      }
    }
    var notification = $(this).data('notification');
    $.getScript(redirect + ".js?&notification=" + notification);
  });
}