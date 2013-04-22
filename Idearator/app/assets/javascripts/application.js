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
//= require_tree .
before_search = false;
var original;
$(function() {
	$("#searchdiv input").keyup(function(){
		//alert(this.value);
		if (window.location == "http://localhost:3000/"){
		$.get($("#searchdiv").attr("action"), $("#searchdiv").serialize(),null,"script");
}else{
	if (!before_search){
			before_search = true;
			original = $("#main").clone();
		}
		if (this.value!=""){
			$.get($("#searchdiv").attr("action"), $("#searchdiv").serialize(),null,"script");
	}else{
		before_search = false;
		$("#main").replaceWith(original);
		apply_dashboard_ideas_js();
		add_notification_event_handlers();
		add_sharing_handlers();
		add_modal_handlers();
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




