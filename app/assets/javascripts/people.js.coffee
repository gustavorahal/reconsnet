
jQuery ->
  $(document).off 'click', '.remove_fields'
  $(document).on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.tel-fieldset').hide()
    event.preventDefault()

  $(document).off 'click', '.add_fields'
  $(document).on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()