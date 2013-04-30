function poll() {
  console.log("POLLLLING");
  $.ajax({
    url: 'http://localhost:9292/poll',
    dataType: "script",
    tryCount : 0,
    retryLimit : 5,
    success: function(data, textStatus, jXHR){
      $.ajax(this);
        return;
    },
    error: function(jXHR, textStatus, errorThrown){
      if(errorThrown == 'timeout'){
        $.ajax(this);
        return;
      }else{
        tryCount ++;
        if(tryCount <= retryLimit){
          {setTimeout(poll, 10000)}
        }else{
          alert('You\'ve been disconnected');
          return;
        }
      }
    },
    timeout: 30000
  });
}

$(function () {
  setTimeout(poll, 1000);
});
