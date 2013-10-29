jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
  $('.datepicker').datepicker(
    autoclose: true,
    format: 'mm/dd/yyyy',
		todayHighlight: true
  )
  setTimeout ->
    $(".alert").fadeOut(500)
  , 2000
