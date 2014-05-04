module ApplicationHelper

  def date_display(date)
    if date.year == Time.now.year
      I18n.l date, format: :short
    else
      I18n.l date, format: :long
    end
  end

end
