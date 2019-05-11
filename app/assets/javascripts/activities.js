// Hack para fazer funcionar tinymce com turbolinks
// Ver: https://github.com/spohlenz/tinymce-rails/issues/145
$(document).on('turbolinks:request-end', function() {
    if (tinyMCE) { tinyMCE.remove(); }
});