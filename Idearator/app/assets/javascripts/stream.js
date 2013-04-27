// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var currentpage = 1;
var thistag = [];
var searchtext = "";
will_insert = true;

function stream_manipulator(page,tag,search,insert){
  $('#search_button').click(function remove_button_handler(e) {e.preventDefault(); });
  currentpage = page;
  searchtext = search+"";
  will_insert = insert;
  inside = 0;

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
    $.ajax({
      url: '/stream/index?page=' + currentpage,
      type: 'get',
      dataType: 'script',
      data: { mypage: currentpage, tag: thistag, search: searchtext},
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
          data: { mypage: currentpage, tag: thistag, search: searchtext},
          success: function() {
          }
        });
        break;
      }
    }
}
//alert(currentpage);
}
  $(window).scroll (function(){
  //alert($(window).scrollTop());
    if($(window).scrollTop()!=0){
      if ($(window).scrollTop() > $(document).height() - $(window).height() - 50){
        currentpage++;
    //stream_manipulator(currentpage,"",searchtext);
        $.ajax({
          url: '/stream/index?page=' + currentpage,
          type: 'get',
          dataType: 'script',
          data: { mypage: currentpage, tag: thistag, search: searchtext},
          success: function() {
          //alert("2nd "+currentpage);
          }
        });
      }
    }
  });

$(document).ready(stream_manipulator(1,"","",true));