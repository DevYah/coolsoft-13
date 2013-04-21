$(window).load(function(){
  var page = 1,
  loading = false;

  function nearBottomOfPage() {
    return $(window).scrollTop() > $(document).height() - $(window).height() - 100;
  }

  $('#filter').click(function() {
    page = 1;
  });

  $(window).scroll(function(){
    if (loading) {
      return;
    }
    if(nearBottomOfPage()) {
      loading=true;
      page++;
      var array = [];
      var i = 0;
      $('#tags label').each(function() {
        array[i] = $(this).text();
        i++;
      });
      $.ajax({
        type: 'POST',
        url: '/home/index',
        data: {
          myTags : array,
          myPage : page
        },
        beforeSend:function(){
        // this is where we append a loading image
        //$('#ajax-panel').html('<div class="loading"><img src="/images/loading.gif" alt="Loading..." /></div>');
      },
      success:function(array){
        loading = false;
      },
      error:function(){
        // failed request; give feedback to user
      }
    });
    }
  });

  $('#click').click(function(){
    $('#fil').toggleClass('hidden');
  });

  $("#input-facebook-theme").tokenInput('/tags/ajax', {
    theme: "facebook",
    preventDuplicates: true,
    tokenLimit: 5
  });

  $('#filter').click(function() {
    var array = [];
    var i = 0;
    $('.token-input-list-facebook li p').each(function() {
      array[i] = $(this).text();
      i++;
    });
    $.ajax({
      type: 'POST',
      url: '/ideas/filter',
      data: { myTags : array },
      beforeSend:function(){
      // this is where we append a loading image
      //$('#ajax-panel').html('<div class="loading"><img src="/images/loading.gif" alt="Loading..." /></div>');
    },
    success:function(array){
    },
    error:function(){
        // failed request; give feedback to user
        alert('failure');
      }
    });
  });

});