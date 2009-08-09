/**
File: wee.js
*****
All the javascript that's fit to print.
*/


/** Shows the billing info form. */
function show_billing() {
	if ($('#billing_info').is(":hidden")) {
		$('#billing_info').fadeIn();
	} 
}

/** Hides the billing info form. */
function hide_billing() {
	if ($('#billing_info').is(":visible")) {
		$('#billing_info').fadeOut();
	} 
}