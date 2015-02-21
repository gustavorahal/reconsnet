

class EventBasePdf < BasePdf

  def initialize(event, current_user)
    super({ page_layout: :landscape, page_size: 'A4' })
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

    image "app/assets/images/logomarca_recons.jpg", :scale => 0.50

    text_box "Gerado #{I18n.l DateTime.now} por #{@current_user.name}",
             align: :right, valign: :top, style: :italic, size: 9

    font 'Times-Roman'

    font('Times-Roman', size: 18, style: :bold) { text @event.name, align: :center }
    move_down 5

    font('Times-Roman', size: 12) {
      text "Data: #{start_date_str} a #{finish_date_str}  |  Local: Reconscientia", align: :center
    }

    move_down 30

  end


  def body
    raise NotImplementedError
  end


  def footer
    number_pages '<page>/<total>', {align: :right, :at => [bounds.right - 50, 0]}
  end


end
