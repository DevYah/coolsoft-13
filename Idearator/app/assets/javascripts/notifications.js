$(document).ready(function() {
	$('div.invite-committee').click(function () {
		$(this).removeClass('unread')
		$(this).addClass('read')
		window.location.href='/users/expertise';
	});

	$('div.idea').click(function () {
		window.location.href='/users/confirm_deactivate';
	});

	$('.unread').hover(function () {
		$(this).toggleClass('unread-select');
	});

	$('.read').hover(function () {
		$(this).toggleClass('read-select');
	});

	$('div.approve-committee').click(function () {
		window.location.href='/users/confirm_deactivate';
	});
})