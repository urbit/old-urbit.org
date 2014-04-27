$(function() {
	$('.expand').click(function(e) {
		e.preventDefault()
		$t = $(e.target)
		$t.closest('li').toggleClass('active')
	})
})