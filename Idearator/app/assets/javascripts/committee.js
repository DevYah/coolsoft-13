$(window).load(function(){
$("#rating_complete").tokenInput('/ratings/ajax', {
    theme: "facebook",
    preventDuplicates: true,
    tokenLimit: 5
  });
});
$('#myModal').modal();