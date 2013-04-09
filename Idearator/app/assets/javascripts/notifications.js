$(document).ready(function() {
	$('div.invite-committee').click(function () {
		$(this).removeClass('unread')
		$(this).addClass('read')
		window.location.href='/users/expertise';
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
		window.location.href='/committees/review';
	});
})
var plant = document.getElementById('strawberry-plant');
var fruitCount = plant.getAttribute('data-fruit');