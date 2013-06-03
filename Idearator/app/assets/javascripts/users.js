

$(document).ready(function() {

  $('.best_in_place').best_in_place();

  $('.best_in_place').bind("ajax:success", function(){
    $('#edited-check-mark').remove();
    $(this).append("<i class='icon-ok pull-right' id ='edited-check-mark'></i>");
  });

  $.datepicker.setDefaults({
    dateFormat: 'yy/mm/dd', changeMonth: true,
    changeYear: true, yearRange: 'c-65:c+10'
  });

});
