$(document).ready(function() {
	$('#articles').find('#details').hide().end().find('#lien').click(function() {
	 var answer = $(this).next();
	 if (answer.is(':visible')) {
		 answer.slideUp();
	 } else {
		 answer.slideDown();
	 }
 });
});
$(document).ready(function() {
	$('#notes').find('#details').hide().end().find('#lien').click(function() {
	 var answer = $(this).next();
	 if (answer.is(':visible')) {
		 answer.slideUp();
	 } else {
		 answer.slideDown();
	 }
 });
});
$(document).ready(function() {
	$('#parcours').find('#details').hide().end().find('#lien').click(function() {
	 var answer = $(this).next();
	 if (answer.is(':visible')) {
		 answer.slideUp();
	 } else {
		 answer.slideDown();
	 }
 });
});