/**
File: wee.js
*****
All the javascript that's fit to print.
*/

function switch_large_image(image_path) {
	var source = image_path.id;
	$('#large_image').empty();
	$('<img src=' + source + '>').appendTo('#large_image');
	$('#large_image').fadeIn();
}


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

/** Toggles the visibility of the price field when user clicks "For Sale" */
function toggle_price_field() {
	if ($('#piece_price').is(":hidden")) {
		$('#piece_price').fadeIn();
	} else if ($('#piece_price').is(":visible")) {
		$('#piece_price').fadeOut();
	}
}