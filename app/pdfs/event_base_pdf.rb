

class EventBasePdf < BasePdf

  def initialize(event, current_user)
    super({ page_layout: :landscape, page_size: 'LETTER' })
    @event = event
    @current_user = current_user
    header
    body
    footer
  end

  def header

    @dates = (@event.start.to_date..@event.finish.to_date).map { |d| I18n.l(d) }
    start_date_str = I18n.l @event.start.to_date
    finish_date_str = I18n.l @event.finish.to_date

    image 'app/assets/images/logomarca_recons.jpg', :scale => 0.50

    text_box "Gerado #{I18n.l DateTime.now} por #{@current_user.name}",
             align: :right, valign: :top, style: :italic, size: 9

    font @@default_font, size: 10

    font(@@default_font, size: 18, style: :bold) { text @event.name, align: :center }
    move_down 5

    if start_date_str == finish_date_str
      subtitle = "Data: #{start_date_str}"
    else
      subtitle = "Data: #{start_date_str} a #{finish_date_str}"
    end

    subtitle +=  '  |  Local: Reconscientia'

    font(@@default_font, size: 12) {
      text subtitle, align: :center
    }

    move_down 20

  end


  def body
    raise NotImplementedError
  end


  def footer
    number_pages '<page>/<total>', {align: :right, :at => [bounds.right - 50, 0]}
  end


end
