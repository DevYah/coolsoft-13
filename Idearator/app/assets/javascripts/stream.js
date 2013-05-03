// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var currentpage = 1;
var thistag = [];
var searchtext = "";
will_insert = true;
user_search = false;
var previous_search = "";

function stream_manipulator(page,tag,search,insert,user){
  currentpage = page;
  searchtext = search+"";
  will_insert = insert;
  inside = 0;
  user_search = user;
  if(user_search == "false"){
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
  stream_manipulator(1,tag.val(),"",true, "false");
  });
 $(".close").click(function tag_remover(e){
  e.preventDefault();
  var curr = $(this);
  $("#search").val("");
  $("#searchtype").val("false");
  stream_manipulator(1,curr.val(),"",false, "false");
});
 $(window).scroll (function(){
  currentpage = call_infinite_scrolling("stream","index",currentpage,"");
  console.log(currentpage);
});
});

function call_infinite_scrolling(controller,action,page,id){
  if(id == ""){
    var url_to_go = '/'+controller+'/'+action+'?page='+page;
  }else{
    var url_to_go = '/'+controller+'/'+id+'?page='+page;
  }
  if($(window).scrollTop()!=0){
    if ($(window).scrollTop() > $(document).height() - $(window).height() - 50){
      page++;
      $.ajax({
        url: url_to_go ,
        type: 'get',
        dataType: 'script',
        data: { mypage: page },
        success: function() {
        }
      });

    }
  }
  return page;
}