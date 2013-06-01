// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var thispage = 1;
var loading = false;

function tag_exists(tag){
  for(var i = 0; i < $("#comp-all").data("comp-tags").length; i++){
    if($("#comp-all").data("comp-tags")[i]==tag){
      return true;
    }
  }
  return false;
}

function apply_comp_tag_handler(){
  $(".aTag").click(function(e){
    e.preventDefault();
    var curr_tag = $(this).attr("value");
    if(!tag_exists(curr_tag)){
      $("#comp-all").data("comp-tags",($("#comp-all").data("comp-tags")).concat([curr_tag]));
      thispage = 1;
    }
    $("#comp-all").html("");
    request();
  });
  $(".delete-token").click(function(e){
    e.preventDefault();
    var tag_remove = $(this).attr("value");
    
      for (var i = 0; i < $("#comp-all").data("comp-tags").length; i++) {
        if ($("#comp-all").data("comp-tags")[i] == tag_remove) {
          $("#comp-all").data("comp-tags").splice(i,1);
          thispage = 1;
          break;
        }
      }
    $("#comp-all").html("");
    request();
  });
}

$(document).ready(function() {
  apply_comp_tag_handler();
  var prePopulate = [];

  $("#competition-tags .competition-tag input:checked").each(function(i, checkbox) {
    checkbox = $(checkbox);
    prePopulate.push({id: checkbox.val(), name: checkbox.data("tag-name")});
  });

  $("#competition-tags").html('<input type="text" id="tag_token_input" name="blah2" />')

  $("#tag_token_input").tokenInput('/tags/ajax', {
    theme: "facebook",
    preventDuplicates: true,
    tokenLimit: 5,
    tokenFormatter: function(item){
      return "<li>" + item.name
           + "<input id='competitions_tags_tags_' type='hidden' value='" + item.id + "' name='competition[tag_ids][]' />"
           + "</li>";
    },
    prePopulate: prePopulate
  });

  $('.best_in_place').best_in_place();
  $('.best_in_place').bind("ajax:success", function(){
    $('#edited-check-mark').remove();
    $(this).append("<i class='icon-ok pull-right' id ='edited-check-mark'></i>");
  });
    $.datepicker.setDefaults({
    dateFormat: 'yy/mm/dd', changeMonth: true,
    changeYear: true, yearRange: '2013:' + (new Date().getFullYear() +8)
  });

function nearBottomOfPage() {
  return $(window).scrollTop() > $(document).height() - $(window).height() - 100;
}

$(window).scroll(function () {
  if(in_comp_index){
    if (loading) {
      return;
    }
    
    if (nearBottomOfPage() && $("#search").val() === '') {
      loading = true;
      thispage += 1;
      request();
   }
  }else{
    thispage = call_infinite_scrolling("competitions","",thispage,$("#stream_competition").attr("value"),[]);
  }
});
});

function request(){
  $.ajax({
    type: 'get',
    url: '/competitions',
    data: {
      comp_page: thispage,
      tags:$("#comp-all").data("comp-tags"),
      state:$("#comp-all").data("state")
    },
    success: function () {
      loading = false;
    }
  });
}