var addthis_config = {"data_track_addressbar":true};


var show = {
	init: function(){
		$("#share").click(function () {
			$("#show").toggle("slow");
		});
		$("#fb").hover(function () {
    		$("#facebook").toggle();
		});
	}
}

$(document).ready(function() {
	show.init();
});
