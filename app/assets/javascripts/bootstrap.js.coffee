jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $('.datepicker').datepicker(
    autoclose: true,
    format: 'mm/dd/yyyy',
		todayHighlight: true
  )
