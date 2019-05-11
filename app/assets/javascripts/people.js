jQuery(function() {
    $(document).off('click', '.remove_fields');
    $(document).on('click', '.remove_fields', function(event) {
        $(this).prev('input[type=hidden]').val('1');
        $(this).closest('.tel-fieldset').hide();
        return event.preventDefault();
    });

    $(document).off('click', '.add_fields');
    return $(document).on('click', '.add_fields', function(event) {
        var time = new Date().getTime();
        var regexp = new RegExp($(this).data('id'), 'g');
        $(this).before($(this).data('fields').replace(regexp, time));
        return event.preventDefault();
    });
});