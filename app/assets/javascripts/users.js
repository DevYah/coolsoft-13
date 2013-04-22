$(document).ready(function() {

  $("#submit").click(function() {
    $('#myModal').modal('hide');
  });

  $("#cancel").click(function() {
    $('#myModal').modal('hide');
  });

  $('.best_in_place').best_in_place();

  $.datepicker.setDefaults({ dateFormat: 'yy/mm/dd', changeMonth: true,
      changeYear: true, yearRange: '1900:' + (new Date().getFullYear() - 8)
  });

});