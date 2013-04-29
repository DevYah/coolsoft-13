// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var currentpage = 1;
var thistag = [];
searchtext = "";
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
//alert(currentpage);
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
          data: { mypage: currentpage, tag: thistag, search: searchtext, search_user: user_search},
          success: function() {
          //alert("2nd "+currentpage);
          }
        });
      }
    }
  });
$(document).ready(function(){
$("#user-search-button").click(function remove_button_handler(e) {
    e.preventDefault(); 
    search_type = true;
    //alert(search_type);
});
  $('#idea-search-button').click(function remove_button_handler(e) {
    e.preventDefault();
    search_type = false;
    //alert(search_type);
});
});