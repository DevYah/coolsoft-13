var last_search = "";
var original;
search_type = false;
typing = false;

$(function() {
  $("#searchdiv input").keyup(function(e){
    e.preventDefault();
  if(e.which != 13){
    var search = $("#search").val();
      if($("#search").val()!= ""){
        if(last_search != search){
          // setTimeout(function(){fix_side_bar()}, 900);
          $("#autocomplete-search").slideDown(1000);
          last_search = search;
          search_autocompleter();
        }
      }else{
        if(last_search != search){
          last_search="";
          $("#autocomplete-search").slideUp(1000);
        }
      }
    }
  });
});

$(document).on('ajaxStart', function(){
  $("#full-component").html("");
  $("#autocomplete-search").css("min-height",70);
  $('#spinner-inner-autocomplete').show();
});

$(document).on('ajaxStop', function(){
  $("#autocomplete-search").css("min-height","");
  $('#spinner-inner-autocomplete').hide();
});

function search_autocompleter(){
  $.get($("#searchdiv").attr("action"), $("#searchdiv").serialize(),null,"script");
}

 function autocomplete_manipulator(){
    var window_height = $(window).height();
    if($(window).height() < $("#autocomplete-search").height()){
      $("#autocomplete-search").css("max-height",window_height-100);
    }
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

function autocomplete_horizontal_positioning(){
  var left_autocomplete = ($(".input-append").offset().left);
  $("#autocomplete-search").css("left",left_autocomplete);
}


$(document).ready(function() {
  set_search();
  autocomplete_horizontal_positioning();
  $(document).click(function(evt) {
    if(evt.target.id == "search"){
      if(!($("#autocomplete-search").is(":visible")) && ($("#search").val() != "")){
        $("#autocomplete-search").slideDown(1000);
        search_autocompleter();
      }
      return;
    }else{
      $("#autocomplete-search").slideUp(1000);
    }
  });
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
      e.preventDefault();
  });
  autocomplete_manipulator();
  $(window).resize(function(){
    autocomplete_manipulator();
    if($(window).width() < 977){
      $("#autocomplete-search").fadeOut(1000);
    }else{
      autocomplete_horizontal_positioning();
    }
  });
});