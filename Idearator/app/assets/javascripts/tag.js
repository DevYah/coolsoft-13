
//This function displays the modal of show as soon as it dissapears for any reason
$(document).ready(function () { 
   if($('div.modal-backdrop').length==0)
     $('div#example').modal()
 })