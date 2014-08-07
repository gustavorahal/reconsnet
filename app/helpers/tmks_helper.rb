module TmksHelper

  def participation_status_icon(participation)
    status = participation.status if participation
    case status
      when 'Inscrito' then icon = 'ok'; color = 'success'; help = ''
      when 'Interessado' then icon = 'asterisk'; color = 'danger'; help = 'Fechar participação!'
      when 'Pré-inscrito' then icon = 'minus'; color = 'warning'
    end

    "<span class=\"glyphicon glyphicon-#{icon} text-#{color}\" title=\"#{help}\"></span>".html_safe
  end

end