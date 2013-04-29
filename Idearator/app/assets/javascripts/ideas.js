function postVote(i, s) {
  FB.api(
  'me/idearator:vote',
  'post',
  {
    idea: s+"ideas/"+i
  },
       function(response) {
         if (!response) {
           alert('Error occurred.');
         } else if (response.error) {
          alert(response.error.message);
         } else {
          alert('<a href=\"https://www.facebook.com/me/activity/' + response.id + '\">' +
             'Story created.  ID is ' + response.id + '</a>');
           document.getElementById('result').innerHTML =
             '<a href=\"https://www.facebook.com/me/activity/' + response.id + '\">' +
             'Story created.  ID is ' + response.id + '</a>';
         }
       }
    );
  };

  function postCreate(i, s) {
  FB.api(
  'me/idearator:create',
  'post',
  {
    idea: s+"ideas/"+i
  },
       function(response) {
         if (!response) {
           alert('Error occurred.');
         } else if (response.error) {
          alert(response.error.message);
         } else {
          alert('<a href=\"https://www.facebook.com/me/activity/' + response.id + '\">' +
             'Story created.  ID is ' + response.id + '</a>');
           document.getElementById('result').innerHTML =
             '<a href=\"https://www.facebook.com/me/activity/' + response.id + '\">' +
             'Story created.  ID is ' + response.id + '</a>';
         }
       }
    );
  };
$(document).ready(function() {

  // When The user clicks on facebook share or twitter share button, this method
  // gets the current URL of the current page and apends it to the default facebook
  // and twitter sharing URLs.
  // This page's URl is then shared on The user's facebook or twitter account.
  // Author: Mohamed Sameh

  $(".fbk").tooltip({
    toggle: "tooltip",
    title: "Share on Facebook",
  });

  $(".tw").tooltip({
    toggle: "tooltip",
    title: "Share on Twitter"
  });

  $(".pin").tooltip({
    toggle: "tooltip",
    title: "Share on pin",
  });

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
    },
    prePopulate: prePopulate
  });

  $('.best_in_place').best_in_place();
  $('.best_in_place').bind("ajax:success", function(){
    $('#edited-check-mark').remove();
    $(this).append("<i class='icon-ok pull-right' id ='edited-check-mark'></i>");
  });


  $("input, select, textarea").on("focus", function(){
   $(this).siblings("span").css("display", "inline");
  }).on("blur", function(){
   $(this).siblings("span").css("display", "none");
  });
});