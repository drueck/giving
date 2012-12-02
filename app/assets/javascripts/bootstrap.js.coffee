jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $('.datepicker').datepicker(
    autoclose: true,
    format: 'mm/dd/yyyy',
		todayHighlight: true
  )
  setTimeout ->
    $(".alert").fadeOut(500)
  , 2000
