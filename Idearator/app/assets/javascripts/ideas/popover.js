$(document).ready(function () {
  $('a[data-popover-idea-id]').click(function (e) {
    e.preventDefault();
    //alert("hesham");
    var id = $(this).data("popover-idea-id");
    $.getScript('/ideas/' + id + '/popover');

});
});