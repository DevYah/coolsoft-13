$('div.addComment .text_area').val('');
$('table#comments').append('<%= escape_javascript(render partial: '/comments/comment', locals: { comment: Comment.last }) %>');