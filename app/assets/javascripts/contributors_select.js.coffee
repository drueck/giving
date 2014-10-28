$ ->
  initContributorSelect() if contributorSelectPresent()
  window.Giving = window.Giving || {}
  window.Giving.initContributorSelect = initContributorSelect

contributorSelectPresent = ->
  $("#contributor-name").length

initContributorSelect = ->
  $('#contributor-name').typeahead({
    source: Giving.contributors,
    itemSelected: (item, val, text) ->
      $('#contribution_contributor_id').val(parseInt(val, 10))
  })
