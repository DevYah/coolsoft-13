function add_modal_handlers(){
   $("#submit").click(function() {
      $('#myModal').modal('hide');
    });
    $("#cancel").click(function() {
      $('#myModal').modal('hide'); 
    });
}
$(document).ready(add_modal_handlers);