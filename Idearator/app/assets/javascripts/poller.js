function poll() {
  console.log("POLLLLING");
  $.ajax({
    url: 'http://localhost:9292/poll',
    dataType: "script",
    success: poll,
    error: function () { setTimeout(poll, 5000); },
    timeout: 180000
  });
}

$(function () {
  poll();
});
