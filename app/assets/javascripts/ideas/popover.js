$(document).ready(function () {
  $('a[data-popover-idea-id]').click(function (e) {
    e.preventDefault();
    e.stopPropagation();
    var id = $(this).data("popover-idea-id");
    $.getScript('/ideas/'+id+'/popover?id=' + id);

  });
});