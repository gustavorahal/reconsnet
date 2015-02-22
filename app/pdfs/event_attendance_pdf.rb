

class EventAttendancePdf < EventBasePdf

  def body

    count = 1
    enrolls = [['#', 'Nome', 'E-mail', 'Telefone'] + @dates ]
    @event.participants([Participation.statuses[:enrolled],
                         Participation.statuses[:pre_enrolled]]).each do |p|
      numbers = p.person.phone_numbers.map {|pn| pn.number.phony_formatted}
      enrolls.append [count, p.person.name, p.person.email + "\n\n", numbers.join("\n")] + @dates.map {|d| Prawn::Text::NBSP * 13}
      count += 1
    end

    # Adicionar linhas em branco a mais para inscrições de última hora,
    # colocar 30% a mais que os inscritos atuais
    (count * 0.30).ceil.times do
      enrolls.append(Array.new(enrolls[0].size, ' '))
    end

    gen_table enrolls, nil, {1 => 150, 2 => 200, 3 => 120}

    move_down 30
    font(@@default_font, size: 13, style: :bold) { text 'Equipe Docente' }
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
