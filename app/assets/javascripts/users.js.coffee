$ ->
  $("#users .pagination a").live "click", ->
    $.getScript(this.href)
    return false
