var last_search = "";
var original;
search_type = false;
typing = false;

$(function() {
  $("#searchdiv input").keyup(function(e){
    e.preventDefault();
  if(e.which != 13){
    typing = true;
    var search = $("#search").val();
    var search_in = $("#searchtype").val();
      if($("#search").val()!= ""){
          setTimeout(function(){fix_side_bar()}, 900);
            $("#autocomplete-search").slideDown(1000);
            search_autocompleter();
      }else{
        $("#autocomplete-search").slideUp(1000);
      }
    }
  });
});

$(document).on('ajaxStart', function(){
  $("#full-component").html("");
  $("#autocomplete-search").css("min-height",100);
  $('#spinner-inner-autocomplete').show();
});

$(document).on('ajaxStop', function(){
  $("#autocomplete-search").css("min-height","");
  $('#spinner-inner-autocomplete').hide();
});

function search_autocompleter(){
  $.get($("#searchdiv").attr("action"), $("#searchdiv").serialize(),null,"script");
}

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
  setTimeout(function(){$(".alert-success").fadeOut(1000);},5000);
  if($("#in-stream-component").is(":visible")){
    $(".alert-success").css("width",770);
  }
  $(".scrollshow").show();
  
  $("#sign").click(function() {
    window.location= "/users/sign_in";
  });

  $("#user-search-button").click(function remove_button_handler(e) {
    e.preventDefault();
    search_type = true;
    $("#searchtype").val("true");
    $(".idea-search").hide();
    $(".user-search").show();
  });

  $("#idea-search-button").click(function remove_button_handler(e) {
    e.preventDefault();
    search_type = false;
    $("#searchtype").val("false");
    $(".user-search").hide();
    $(".idea-search").show();
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