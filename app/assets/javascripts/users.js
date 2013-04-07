var action={
    init: function(){
        $("#submit").click(function() {
          $('#myModal').modal('hide');
        });
        $("#cancel").click(function() {
          $('#myModal').modal('hide'); 
        });
    }
}

$(document).ready(function() {
  action.init();
});