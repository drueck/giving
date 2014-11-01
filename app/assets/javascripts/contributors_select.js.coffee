$ ->
  initContributorSelect() if contributorSelectPresent()
  window.Giving = window.Giving || {}
  window.Giving.initContributorSelect = initContributorSelect

contributorSelectPresent = ->
  $("#contributor-name").length

initContributorSelect = ->
  $('#contributor-name').typeahead(source: Giving.contributors)
