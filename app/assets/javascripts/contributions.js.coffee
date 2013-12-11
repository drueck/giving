$ ->

  $("#contributions .pagination a").on "click", ->
    $.getScript(this.href)
    return false
