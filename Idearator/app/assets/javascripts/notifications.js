function add_notification_event_handlers() {
  $('div.invite-committee-notification').click(function () {
    var notification = $(this).data('notification');
    $.getScript("/redirect_expertise.js?&notification=" + notification);
  });

  $('div.idea-notification').click(function () {
    var notification = $(this).data('notification');
    $.getScript("/redirect_idea.js?&notification=" + notification);
  });

  $('div.approve-committee-notification').click(function () {
    var notification = $(this).data('notification');
    $.getScript("/redirect_review.js?&notification=" + notification);
  });

  $('div.delete-notification').click(function () {
    var notification = $(this).data('notification');
    $.getScript("/set_read.js?&notification=" + notification);
  });
}

$(document).ready(add_notification_event_handlers);