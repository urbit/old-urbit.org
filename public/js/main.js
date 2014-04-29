$(
  function() {
    $('.expand').click(function(e) {
      $t = $(e.target)
      $t.closest('li').toggleClass('active')
    })
  }
)
