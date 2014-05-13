$(function() {
	$subnav = $('.subnav')
	$window = $(window)
	rem = parseFloat(getComputedStyle(document.documentElement).fontSize)
	setSize = function() {
		if($window.width() < rem*54)
			$subnav.attr('style', '')
		else
			$subnav.height($window.height() - $subnav.position().top)
	}
	setSize()
	$window.on('resize', setSize)
})