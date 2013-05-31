var last_search = "";
var original;
search_type = false;

$(function() {
  $("#searchdiv input").keyup(function(e){
    e.preventDefault();
  if(e.which != 13){
    var search = $("#search").val();
    var search_in = $("#searchtype").val();
      if($("#search").val()!= ""){
        if(search.length > 2 || e.which == 8){
          if($("#landing").is(":visible")){
            $("#landing").hide();
            $('#landing-stream').show();
            stream_manipulator(1,[],search,"false", search_in);
            $('html, body').animate({scrollTop:0}, 'slow');
            $("#in-stream-component").slideDown(1000);
          }else{
            stream_manipulator(1,[],search,"false", search_in);
            $('html, body').animate({scrollTop:0}, 'slow');
          }
        }
      }else{
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

  setTimeout(function(){$(".alert-success").fadeOut(1000);},5000);

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