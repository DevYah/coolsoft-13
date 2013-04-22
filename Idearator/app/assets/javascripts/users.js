$(document).ready(function() {
   $("#submit").click(function() {
      $('#myModal').modal('hide');
    });
    $("#cancel").click(function() {
      $('#myModal').modal('hide');
    });
    $('.best_in_place').best_in_place()
});