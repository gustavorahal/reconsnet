module TmksHelper

  def tmk_annotation(tmk)
    "<em>\"#{tmk.notes}\"</em> <small class=\"text-muted\">por #{tmk.from_who.name} há #{time_ago_in_words tmk.contact_date}</small>".html_safe
  end


  ##
  # Exemplo output: Sobre A Semiótica Peirceana e a Descrenciologia (06 Dez 2014) "tem interesse" por Voluntário do TMK há 16 dias

  def tmk_summary_no_with_who(tmk, hide_event_name)
    text = 'Sobre '
    text += hide_event_name ? ' este evento ' : event(tmk)
    text += tmk_annotation(tmk)
    text.html_safe
  end


  ##
  # Exemplo output: José da Silva "esta em duvida" por Voluntário do TMK há 4 dias

  def tmk_summary_no_event(tmk)
    (with_who(tmk) + tmk_annotation(tmk)).html_safe
  end


  private

    def with_who(tmk)
      "#{link_to tmk.with_who.name, person_path(tmk.with_who)} "
    end

    def event(tmk)
      "<em>#{link_to tmk.event.name_with_date, event_path(tmk.event)}</em> "
    end

end