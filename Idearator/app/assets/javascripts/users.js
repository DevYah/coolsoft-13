
function add_modal_handlers(){
   $("#submit").click(function() {
      $('#myModal').modal('hide');
    });
    $("#cancel").click(function() {
      $('#myModal').modal('hide');
    });
}

function add_best_in_place(){
  $('.best_in_place').best_in_place();

  $.datepicker.setDefaults({ dateFormat: 'yy/mm/dd', changeMonth: true,
      changeYear: true, yearRange: '1900:' + (new Date().getFullYear() - 8)
  });
}

$(document).ready(add_modal_handlers);
$(document).ready(add_best_in_place);
