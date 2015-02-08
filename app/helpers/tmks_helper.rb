module TmksHelper

  def tmk_summary(tmk, show_event=true)
    text = show_event ? "#{link_to tmk.event.name_with_date, event_path(tmk.event)}" : 'Este evento '

    unless tmk.notes.blank?
      text += " por #{tmk.from_who.name} com a anotação <strong><em>\"#{tmk.notes}\"</em></strong>"
    end

    text += "<small><span class=\"pull-right text-muted\">há #{time_ago_in_words tmk.contact_date}</span></small>"

    text += render 'common/btn_edit', resource: tmk, size: 'btn-xs', btn_label: ''
    text.html_safe
  end

end