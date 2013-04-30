// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var currentpage = 1;
var thistag = [];
var searchtext = "";
will_insert = true;
user_search = false;
var previous_search = "";

// function change_state(user){

// }

function stream_manipulator(page,tag,search,insert,user){
  //alert(previous_search);
  currentpage = page;
  searchtext = search+"";
  will_insert = insert;
  inside = 0;
  user_search = user;

if(!user_search){
  if(will_insert){
  if(tag!=""){
    for (var i = 0; i < thistag.length; i++) {
      if (thistag[i] == tag) {
        inside = 1;
        break;
      }
    }
  }else{
      inside = -1;
  }

  if(search != ""){
    thistag = [];
  }
    
  if(inside == 0){
    thistag.push(tag);
  }
  //alert(inside+" "+thistag[0]);
  if (inside != 1){
    $("#stream_results").html("");
    //alert(currentpage+"#"+thistag+"#"+searchtext+"#"+user_search);
    $.ajax({
      url: '/stream/index?page=' + currentpage,
      type: 'get',
      dataType: 'script',
      data: { mypage: currentpage, tag: thistag, search: searchtext, search_user: user_search},
      success: function() {
      }
    });
  }
}else{
  for (var i = 0; i < thistag.length; i++) {
      if (thistag[i] == tag) {
        thistag.splice(i,1);
        $("#stream_results").html("");
        $.ajax({
          url: '/stream/index?page=' + currentpage,
          type: 'get',
          dataType: 'script',
          data: { mypage: currentpage, tag: thistag, search: searchtext, search_user: false},
          success: function() {
          }
        });
        break;
      }
    }
}
}else{
  if(previous_search != searchtext){
  $("#stream_results").html("");
  thistag = [];
    $.ajax({
      url: '/stream/index?page=' + currentpage,
      type: 'get',
      dataType: 'script',
      data: { mypage: currentpage, tag: thistag, search: searchtext, search_user: true},
      success: function() {
        alert("2ndo");
        previous_search = searchtext;
      }
    });
  }
}
}
//alert(currentpage)
$(document).ready(function(){
  alert($("#searchtype").val());
   $(".btn-link").click(function tag_caller(e){
    e.preventDefault();
    var tag = $(this);
    //$("#stream_results").html("");
    $("#search").val("");
    $("#searchtype").val("false");
    stream_manipulator(1,tag.val(),"",true, false);
  });
   $(".close").click(function tag_remover(e){
    e.preventDefault();
    var curr = $(this);
    $("#search").val("");
    $("#searchtype").val("false");
    stream_manipulator(1,curr.val(),"",false, false);
  });
   $(window).scroll (function(){
    if($(window).scrollTop()!=0){
      if ($(window).scrollTop() > $(document).height() - $(window).height() - 50){
        currentpage++;
        $.ajax({
          url: '/stream/index?page=' + currentpage,
          type: 'get',
          dataType: 'script',
          data: { mypage: currentpage, tag: thistag, search: $("#search").val(), search_user: $("#searchtype").val()},
          success: function() {
            console.log($("#searchtype").val());
          }
        });
      }
    }
  });
});