$.ajaxSetup({ cache: true })

$ ->

  Mousetrap.bind ['right', 'l'], clickNext
  Mousetrap.bind ['left', 'h'], clickPrevious

  $(document).on "click", ".pagination a", ->
    $.getScript(this.href)
    return false

  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

  setTimeout ->
    $(".alert").fadeOut(500)
  , 2000

clickNext = ->
  $("a.next_page").click()

clickPrevious = ->
  $("a.previous_page").click()
