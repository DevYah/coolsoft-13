// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//= require jquery
//= require jquery_ujs
//= require jquery.tokeninput
//= require jquery-ui
//= require bootstrap
//= require notification_polling
//= require jquery.purr
//= require best_in_place
//= require_tree .
before_search = false;
var original;
$(function() {
	$("#searchdiv input").keyup(function(){
		if (window.location == "http://localhost:3000/"){
		$.get($("#searchdiv").attr("action"), $("#searchdiv").serialize(),null,"script");
}else{
	if (!before_search){
			before_search = true;
			original = $("#main > .container").detach();
		}
		if (this.value!=""){
			$.get($("#searchdiv").attr("action"), $("#searchdiv").serialize(),null,"script");
	}else{
		before_search = false;
		$("#main > .container").replaceWith(original);
	}
	  }
	});
});


$(document).bind("ajaxError", function(e, xhr){
	if(xhr.status == 401){
		$('#signedout').modal('show');
	}
});

$(document).ready(function() {
  $("#sign").click(function() {
    window.location= "/users/sign_in";
  });
});




