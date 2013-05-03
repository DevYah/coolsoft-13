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
//
//= require jquery
//= require jquery_ujs
//= require ideas/popover
//= require bootstrap
//= require jquery.purr
//= require bootstrap
//= require best_in_place
//
//= require jquery-ui
//= require jquery.tokeninput
//= require jquery-star-rating
//= require jquery_purr
//
//= require notifications
//
//= require accountsettings
//= require unauthorized_sign_in_up_modal
//
//= require profile_modal



function stream_render(e) {
  e.preventDefault();

}


var last_search = "";
var original;
search_type = false;

$(function() {
  $("#searchdiv input").keyup(function(e){
    e.preventDefault();
    $("#landing").hide();
    $('#landing-stream').show();
  if(e.which != 13){
    var search = $("#search").val();
    var search_in = $("#searchtype").val();
      if($("#search").val()!= ""){
        if(search.length > 2){
        stream_manipulator(1,[],search,"false", search_in);
        }
      }else{
        $("#landing").show();
        $(".stream-generate-button").hide();
        $("#searchtype").val("false");
        stream_manipulator(1,[],"","false", $("#searchtype").val());
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
  $("#user-search-button").click(function remove_button_handler(e) {
    e.preventDefault();
    search_type = true;
    $("#searchtype").val("true");
  });
  $("#idea-search-button").click(function remove_button_handler(e) {
    e.preventDefault();
    search_type = false;
    $("#searchtype").val("false");
  });
  $("a.popup").click(function (e) {
    popupCenter($(this).attr("href"),
                $(this).attr("data-width"), $(this).attr("data-height"), "authPopup");
    e.stopPropagation();
    return false;
  });

  $("#twitter_signin_button").tooltip({
    placement: 'bottom',
    trigger: 'click',
    title: 'Trying to sign in using twitter, please interact with the popup!',
    container: 'header'
  });
  $('#searchdiv').submit(function(e) {
    $(".landing").hide();
    if (in_stream){
      e.preventDefault();
    }
  });
});

function popupCenter(url, width, height, name) {
  var left = (screen.width / 2) - (width / 2);
  var top = (screen.height / 2) - (height / 2);
  return window.open(url, name, "menubar=no,toolbar=no,status=no,width=" + width +
                                ",height=" + height + ",toolbar=no,left=" + left +
                                ",top=" + top);
};
