$(function() {
	$subnav = $('.subnav')
	$window = $(window)
	setSize = function() {
		$subnav.height($window.height() - $subnav.position().top)
	}
	setSize()
	$window.on('resize', setSize)
})