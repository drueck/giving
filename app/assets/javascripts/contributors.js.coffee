$ ->

	$('#contributors .pagination a').on 'click', ->
		$.getScript(this.href)
		return false

	$('#contributor-contributions .pagination a').on 'click', ->
		$.getScript(this.href)
		return false

	$('#contributor-search').submit ->
		$.get(this.action, $(this).serialize(), null, 'script')
		return false
