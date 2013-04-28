$(function(){
  poll();
});

function poll(){
  console.log("POLLLLING");
  $.ajax({
  url: 'http://localhost:3000/coolster_app/poll',
  dataType: "script",
  success: poll,
  error: function wait(){setTimeout(poll, 5000);},
  timeout: 180000
  });
}