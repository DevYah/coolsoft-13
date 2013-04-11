function handleKeyPress(e){
 var key=e.which;
  if (key==13){
    var x = $('input').val();
    var prespective =$('<li></li>').text($('input').val());
    $('ul#rating').append(prespective);
    $('input').val("");
  }
}