function add_notification_event_handlers() {
  $('div.invite-committee').click(function () {
    $('div#expertise').appendTo("body").modal()
  });

  $('div.idea').click(function () {
    var idea = this.getAttribute('data-notification')
    window.location.href='/ideas/' + idea;
  });

  $('.unread').hover(function () {
    $(this).toggleClass('unread-select');
  });

  $('.read').hover(function () {
    $(this).toggleClass('read-select');
  });

  $('div.approve-committee').click(function () {
    var user = this.getAttribute('data-notification')
    window.location.href='/users/' + user;
  });
}

$(document).ready(add_notification_event_handlers);