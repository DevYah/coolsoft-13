// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var currentpage = 1;
var thistag = [];
var searchtext = "";
will_insert = true;
user_search = "";
var previous_search = "";

function check_if_exists(tag){
  for(var i = 0; i < thistag.length; i++){
    if(thistag[i]==tag){
      return true;
    }
  }
  return false;
}

function stream_manipulator(page,tag,search,insert,user){
  currentpage = page;
  searchtext = search+"";
  will_insert = (insert == "true");
  user_search = (user == "true");
  reset = "false";

  if (!(searchtext == "" && !user_search && tag == "" && !will_insert)){
    $("#stream_results").html("");
      if (searchtext == "" && !user_search){
        if(will_insert){
          if(!check_if_exists(tag)){
            thistag = tag.concat(thistag);
          }
          searchtext = "";
          user_search = false;
          currentpage = 1;

        }else{
          if (check_if_exists(tag)){
            for (var i = 0; i < thistag.length; i++) {
              if (thistag[i] == tag) {
                thistag.splice(i,1);
                searchtext = "";
                user_search = false;
                currentpage = 1;
                break;
              }
            }
          }else{
            reset = "true";
            searchtext = "";
            user_search = false;
            currentpage = 1;
          }
        }
      }else{
        if(tag == "" && !will_insert){
          if (user_search){
            currentpage = 1;
            searchtext = search+"";
            user_search = true;
            thistag = [];
          }else{
            currentpage = 1;
            searchtext = search+"";
            user_search = false;
            thistag = [];
          }
        }
      }
    }
    if(reset == "true"){
      $.ajax({
        url: '/stream/index?page=' + currentpage,
        type: 'get',
        dataType: 'script',
        data: { mypage: currentpage, tag: thistag, search: searchtext, search_user: user_search, insert: will_insert ,reset_global: reset},
        success: function() {
          apply_tag_handlers();
        }
      });
    }else{
       $.ajax({
        url: '/stream/index?page=' + currentpage,
        type: 'get',
        dataType: 'script',
        data: { mypage: currentpage, tag: thistag, search: searchtext, search_user: user_search, insert: will_insert},
        success: function() {
          apply_tag_handlers();
        }
      });
    }
  }

$(document).ready(function(){ apply_tag_handlers(); });
   function apply_tag_handlers(){
   $("#stream_results .btn-link").click(function tag_caller(e){
    e.preventDefault();
    var tag = $(this);
    $("#search").val("");
    $("#searchtype").val("false");
    stream_manipulator(1,[tag.val()],"","true", "false");
  });
   $("#stream_results .close").click(function tag_remover(e){
    e.preventDefault();
    var curr = $(this);
    $("#search").val("");
    $("#searchtype").val("false");
    stream_manipulator(1,[curr.val()],"","false", "false");
  });
   }


$(window).scroll (function(){
      if($(window).scrollTop()!=0){
        if ($(window).scrollTop() > $(document).height() - $(window).height() - 50){
          currentpage = call_infinite_scrolling("stream","index",currentpage,"",[thistag,$("#search").val(),$("#searchtype").val(),false]);
          }
    }
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
          apply_tag_handlers();
        }
      });
  return page;
}