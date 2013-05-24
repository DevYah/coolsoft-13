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
        if(search.length > 2 || e.which == 8){
          setTimeout(function(){stream_manipulator(1,[],search,"false", search_in)},1000);
          $('html, body').animate({scrollTop:0}, 'slow');
        }
      }else{
        $("#landing").show();
        $(".stream-generate-button").hide();
        $("#searchtype").val("false");
        setTimeout(function(){stream_manipulator(1,[],"","false", $("#searchtype").val())},1000);
        $('html, body').animate({scrollTop:$('#landing').height()}, 'slow');
      }
    }
  });
});

$(document).bind("ajaxError", function(e, xhr){
  if(xhr.status == 401){
    $('#signedout').modal('show');
  }
});

function set_search(){
  if($("#searchtype").val()=="false"){
    $(".user-search").hide();
    $(".idea-search").show();
  }else{
    $(".idea-search").hide();
    $(".user-search").show();
  }
}

$(document).ready(function() {
  set_search();
  $("#sign").click(function() {
    window.location= "/users/sign_in";
  });

  $("#user-search-button").click(function remove_button_handler(e) {
    e.preventDefault();
    search_type = true;
    $("#searchtype").val("true");
    set_search();
  });

  $("#idea-search-button").click(function remove_button_handler(e) {
    e.preventDefault();
    search_type = false;
    $("#searchtype").val("false");
    set_search();
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
    if (in_stream){
      e.preventDefault();
    }
  });

});