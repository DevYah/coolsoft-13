$('#like').html('<%= escape_javascript(render(partial: 'like')) %>');
$('#comment_content').val('');
$("'div#<%= @comment.id %>").parent().popover(options);