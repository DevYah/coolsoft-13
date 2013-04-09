# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

`$(document).ready(function () { 
	if($("div.alert p").text()!="")
		$("div.form-actions p a.btn").click()
	else
		if($("div.modal-backdrop"))
			$("div.alert").hide()
	})`
