// When The user clicks on facebook share or twitter share button, this method gets the current URL of the current page and apends it to the default
// facebook and twitter sharing URLs.
// This page's URl is then shared on The user's facebook or twitter account.
// Author: Mohamed Sameh
$(document).ready(function() {
	$("#share").click(function() {
		$("#show").toggle("slow");
	});
	$("#fbk").click(function() {
		var pathname = window.location;
 		var fburl = 'http://www.facebook.com/sharer.php?u='+encodeURI(pathname);
 		var win=window.open(fburl, 'popup');
 		win.focus();
	});
	$("#tw").click(function() {
 		var pathname = window.location;
  	var tweeturl = 'http://twitter.com/share?url='+encodeURI(pathname)+'&text=Checkout this idea on idearator';
  	var win=window.open(tweeturl, 'popup');
 		win.focus();
	});
	$("#fbk").tooltip({
		toggle: "tooltip",
		title: "Share on Facebook",
	});
	$("#tw").tooltip({
		toggle: "tooltip",
		title: "Share on Twitter"
	});
});

$(document).ready(function() {
  var prePopulate = [];

  $("#idea-tags .idea-tag input:checked").each(function(i, checkbox) {
    checkbox = $(checkbox);
    prePopulate.push({id: checkbox.val(), name: checkbox.data("tag-name")});
  });

  $("#idea-tags").html('<input type="text" id="tag_token_input" name="blah2" />')

  $("#tag_token_input").tokenInput('/tags/ajax', {
    theme: "facebook",
    preventDuplicates: true,
    tokenLimit: 5,
    tokenFormatter: function(item){
      return "<li>" + item.name
           + "<input id='ideas_tags_tags_' type='hidden' value='" + item.id + "' name='idea[tag_ids][]' />"
           + "</li>";
      //"<li>" + "<img src='" + item.url + "' title='"
      //+ item.first_name + " " + item.last_name + "' height='25px' width='25px' />"
      //+ "<div style='display: inline-block; padding-left: 10px;'><div class='full_name'>"
      //+ item.first_name + " " + item.last_name + "</div><div class='email'>" + item.email
      //+ "</div></div></li>";
    },
    prePopulate: prePopulate
  });


  $('.best_in_place').best_in_place();
  $('#image-edit-link,.best_in_place').tooltip({animation: true, title:'Click to edit' , trigger: 'hover', html: true });

  $('.best_in_place').bind("ajax:success", function(){
    $('#edited-check-mark').remove();
    $(this).append("<i class='icon-ok pull-right' id ='edited-check-mark'></i>");
  });
});