module TmksHelper

  def row_background(participation)
    status = participation.status if participation

    case status
      when 'Inscrito' then return 'success'
      when 'Interessado' then return 'danger'
      when 'Pré-inscrito' then return 'warning'
      else return ''
    end

  end

end