# Hack para fazer funcionar tinymce com turbolinks
# Ver: https://github.com/spohlenz/tinymce-rails/issues/145
$(document).on 'page:receive', ->
  tinymce.remove()