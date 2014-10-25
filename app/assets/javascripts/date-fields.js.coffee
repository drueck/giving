$ ->
  $('.datepicker').mask('99/99?/9999', { placeholder: ' ' })
  $('.datepicker').datepicker(
    autoclose: true,
    format: 'mm/dd/yyyy',
    todayHighlight: true,
    forceParse: false
  )
  $('.datepicker').blur ->
    return unless this.value
    date = moment(this.value, ["MM/DD/YYYY", "MM/DD"])
    this.value = if date.isValid() then date.format("MM/DD/YYYY") else ""
