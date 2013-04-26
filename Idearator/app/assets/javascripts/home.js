function nearBottomOfPage() {
  return $(window).scrollTop() > $(document).height() - $(window).height() - 100;
}

function passedPage1() {
  return $(window).scrollTop() > 600;
}

function backToTop() {
  return $(window).scrollTop() < 600;
}

$(document).ready(function () {

  var page = 1;
  var loading = false;

  $('#filter').click(function () {
    page = 1;
  });

  $(window).scroll(function () {
    if (loading) {
      return;
    }
    if (passedPage1()) {
      $('.backtotop').show();
    }
    if (backToTop()) {
      $('.backtotop').hide();
    }
    if (nearBottomOfPage() && $("#search").val() === '') {
      loading = true;
      page += 1;

      var array = [];
      var i = 0;

      $('.tags li label').each(function () {
        array[i] = $(this).text();
        i += 1;
      });

      $.ajax({
        type: 'POST',
        url: '/home/index',
        data: {
          myTags: array,
          myPage: page
        },
        beforeSend: function () {
        // this is where we append a loading image
        //$('#ajax-panel').html('<div class="loading"><img src="/images/loading.gif" alt="Loading..." /></div>');
        },
        success: function (array) {
          loading = false;
        },
        error: function () {
          // failed request; give feedback to user
        }

      });
    }
  });

  if ($('.token-input-list-facebook').length === 0) {
    $('#click').click(function () {
      $('#fil').toggleClass('hidden');
    });

    $("#input-facebook-theme").tokenInput('/tags/ajax', {
      theme: "facebook",
      preventDuplicates: true,
      tokenLimit: 5
    });

    $('#filter').click(function () {
      var array = [];
      var i = 0;

      $('.token-input-list-facebook li p').each(function () {
        array[i] = $(this).text();
        i += 1;
      });

      if (array.length > 0) {
        $.ajax({
          type: 'POST',
          url: '/ideas/filter',
          data: { myTags : array },
          beforeSend: function () {
            // this is where we append a loading image
            //$('#ajax-panel').html('<div class="loading"><img src="/images/loading.gif" alt="Loading..." /></div>');
          },
          success: function (array) {
          },
          error: function () {
            // failed request; give feedback to user
            alert('failure');
          }
        });
      }

    });
  } else {
    alert('Please choose a tag');
  }

  $(".facebook").tooltip({
    toggle: "tooltip",
    title: "Share on Facebook",
  });

  $(".twitter").tooltip({
    toggle: "tooltip",
    title: "Share on Twitter"
  });

});
