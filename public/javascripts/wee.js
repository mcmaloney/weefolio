/**
File: wee.js
All the javascript that's fit to print. And that controls the UI functions in this app.
*/

$(document).ready(function() {
	$('#image_upload_submit').click(function() {
		$('#loading_img').empty().html('<img src="/images/loading.gif" />');
	});
});

/** Switches the thumb into the full size view in the gallery. */
function switch_large_image(image_path, piece) {
	var source = image_path.id;
	var full_size = '#' + piece
	$(full_size).empty();
	$('<img src=' + source + '>').appendTo(full_size);
	$(full_size).fadeIn();
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
