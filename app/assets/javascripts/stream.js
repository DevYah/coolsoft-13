// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var currentpage = 1;
var thistag = [];
var searchtext = "";
will_insert = true;
user_search = "";
var previous_search = "";

function stream_manipulator(page,tag,search,insert,user){
  //alert(previous_search);
  currentpage = page;
  searchtext = search+"";
  will_insert = insert;
  inside = 0;
  user_search = (user == "true");

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

  if (inside != 1){
    $("#stream_results").html("");
    $.ajax({
      url: '/stream/index?page=' + currentpage,
      type: 'get',
      dataType: 'script',
      data: { mypage: currentpage, tag: [tag], search: searchtext, search_user: user_search, insert: will_insert},
      success: function() {
        alert(will_insert);
      }
    });
  }
}else{
  if(search==""){
    if(thistag.length == 0){
      $("#stream_results").html("");
    $.ajax({
      url: '/stream/index?page=' + currentpage,
      type: 'get',
      dataType: 'script',
      data: { mypage: currentpage, tag: thistag, search: searchtext, search_user: user_search, insert: will_insert},
      success: function() {
        alert(will_insert);
      }
    });
    }else{
  for (var i = 0; i < thistag.length; i++) {
      if (thistag[i] == tag) {
        thistag.splice(i,1);
        $("#stream_results").html("");
        $.ajax({
          url: '/stream/index?page=' + currentpage,
          type: 'get',
          dataType: 'script',
          data: { mypage: currentpage, tag: [tag], search: searchtext, search_user: false, insert: will_insert},
          success: function() {
            alert(will_insert);
          }
        });
        break;
      }
    }
  }
  }else{
    thistag = []
    $("#stream_results").html("");
    $.ajax({
      url: '/stream/index?page=' + currentpage,
      type: 'get',
      dataType: 'script',
      data: { mypage: currentpage, tag: thistag, search: searchtext, search_user: user_search, insert: will_insert},
      success: function() {
        alert(will_insert);
      }
    });
  }
}
}else{
  if(previous_search != searchtext){
  $("#stream_results").html("");
    $.ajax({
      url: '/stream/index?page=' + currentpage,
      type: 'get',
      dataType: 'script',
      data: { mypage: currentpage, tag: thistag, search: searchtext, search_user: true, insert: will_insert},
      success: function() {
        alert("2ndo");
        previous_search = searchtext;
      }
    });
  }
}
}
$(document).ready(function(){
   $(".btn-link").click(function tag_caller(e){
    e.preventDefault();
    var tag = $(this);
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
          currentpage = call_infinite_scrolling("stream","index",currentpage,"",[thistag,searchtext,user_search,true]);
          }
    }
        });
      });


 function call_infinite_scrolling(controller,action,page,id,params){
  if(id == ""){
    var url_to_go = '/'+controller+'/'+action+'?page='+page;
  }else{
    var url_to_go = '/'+controller+'/'+id+'?page='+page;
  }
  
      page++;
      $.ajax({
        url: url_to_go ,
        type: 'get',
        dataType: 'script',
        data: { mypage: page, tag: params[0], search: params[1], search_user: params[2], insert: params[3] },
        success: function() {
        }
      });
  return page;
}