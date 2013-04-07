var addthis_config = {"data_track_addressbar":true};

var addthis_share = 
	{ 
	  templates: {
	    twitter: 'Check out this Idea on Idearator   {{url}} ',
	 }
	};

var show = {
	init: function(){
		$("#share").click(function () {
			$("#show").toggle("slow");
		});
		$("#fb").hover(function () {
    		$("#facebook").toggle();
		});
		$("#tw").hover(function () {
    		$("#twitter").toggle();
		});
	}
};

$(document).ready(function() {
	show.init();
});
