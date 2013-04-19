function add_notification_event_handlers() {
  $('div.invite-committee').click(function () {
    $.getScript("/users/send_expertise")
  });

  $('div.idea').click(function () {
    var idea = this.getAttribute('data-notification')
    window.location.href='/ideas/' + idea;
  });

  $('div.approve-committee').click(function () {
    var user = this.getAttribute('data-notification')
    window.location.href='/users/' + user;
  });
}

$(document).ready(add_notification_event_handlers);