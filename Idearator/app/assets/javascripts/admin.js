$(document).ready(function(){
  $('.main').click(function(){
  		$('.invite').removeClass('hidden')
  });
  $('.cancel').click(function(){
  		$('.invite').addClass('hidden');
  });
});