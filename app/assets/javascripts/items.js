$(document).ready(function() {

	// Initialize Masonry
    console.log("hi");
	$('.masonry-container').masonry({
		columnWidth: 320,
		itemSelector: '.item',
		isFitWidth: true,
	}).imagesLoaded(function() {
		$(this).masonry('reload');
	});

});
