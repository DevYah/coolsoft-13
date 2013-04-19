$(document).ready(function() {

  $('.best_in_place').best_in_place();

  $('.best_in_place').bind("ajax:success", function(){

    $('#edited-check-mark').remove();
    $(this).append("<i class='icon-ok pull-right' id ='edited-check-mark'></i>");
  });
});