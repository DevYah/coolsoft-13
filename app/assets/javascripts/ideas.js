$(document).ready(function() {
	$("#share").click(function() {
		$("#show").toggle("slow");
	});
	$("#fbk").click(function() {
		var pathname = window.location;
  		var fburl = 'http://www.facebook.com/sharer.php?u='+encodeURI(pathname);
  		var win=window.open(fburl, 'popup');
 		win.focus();
	});
	$("#tw").click(function() {
 		var pathname = window.location;
 	 	var tweeturl = 'http://twitter.com/share?url='+encodeURI(pathname)+'&text=Checkout this idea on idearator';
  		var win=window.open(tweeturl, 'popup');
 		win.focus();
	});
	$("#fbk").tooltip({
		toggle: "tooltip",
		title: "Share on Facebook",
	});
	$("#tw").tooltip({
		toggle: "tooltip",
		title: "Share on Twitter" 
	});
});
