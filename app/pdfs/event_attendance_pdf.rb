

class EventAttendancePdf < EventBasePdf

  def body

    font('Times-Roman', size: 14, style: :bold) { text 'Inscritos' }
    move_down 10

    count = 1
    enrolls = [['#', 'Nome'] + @dates ]
    @event.enrolls.each do |p|
      enrolls.append [count, p.person.name] + @dates.map {|d| Prawn::Text::NBSP * 13}
      count += 1
    end
    table enrolls do
      row(0).font_style = :bold
      row(0).align = :center
      row(0).font_size = 13
      self.header = true
      self.row_colors = ['DDDDDD', 'FFFFFF']
    end

    move_down 40
    font('Times-Roman', size: 14, style: :bold) { text 'Equipe Organizadora' }
    move_down 10

    count = 1
    organizers = [['#', 'Nome', 'Função'] + @dates]
    @event.organizers.each do |p|
      organizers.append [count, p.person.name, p.participation_type] + @dates.map {|d| Prawn::Text::NBSP * 13}
      count += 1
    end

    gen_table organizers

  end


end
