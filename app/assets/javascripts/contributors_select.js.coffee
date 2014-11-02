$ ->
  initContributorSelect() if contributorSelectPresent()
  window.Giving = window.Giving || {}
  window.Giving.initContributorSelect = initContributorSelect

contributorSelectPresent = ->
  $("#contributor-name").length

initContributorSelect = ->
  initContributorTypeahead()
  initWatchForNewContributor()

initContributorTypeahead = ->
  $('#contributor-name').typeahead('destroy')
  $('#contributor-name').typeahead(source: Giving.contributors, delay: 5)

initWatchForNewContributor = ->
  $('#contributor-name').blur ->
    return unless this.value && this.value.trim() != ''

    enteredName = this.value.trim()
    if not knownContributor(enteredName)
      sweetAlert
        title: "Create new contributor?"
        text: "This will create a new contributor with the name '#{enteredName}'. " +
          "You will need to access the contributor record afterward to provide " +
          "additional details. Do you wish to continue?"
        showCancelButton: true
        (createContributor) ->
          if createContributor
            setTimeout ->
              $('#contribution-date').focus()
              createNewContributor(enteredName)
            , 10
          else
            setTimeout ->
              $('#contributor-name').val("")
              $('#contributor-name').focus()
            , 10

knownContributor = (name) ->
  lowerCaseName = name.toLowerCase()
  _.find Giving.contributors, (name) ->
    name.toLowerCase() == lowerCaseName

createNewContributor = (name) ->
  $.post '/contributors',
    { contributor: { name: name } },
    (contributor) ->
      if contributor.name
        Giving.contributors.push(contributor.name)
        initContributorSelect()
      else
        sweetAlert
          title: "Could not create contributor"
          text: "There was an unexpected error creating the contributor. " +
            "Please try again from the contributors screen."
          type: "error"
    , 'json'
