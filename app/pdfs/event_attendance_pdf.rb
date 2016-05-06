

class EventAttendancePdf < EventBasePdf

  def body

    count = 1
    enrolls = [['#', 'Nome', 'E-mail', 'Telefone'] + @dates ]
    @event.participations.includes(:person).
                          where(p_type: Participation.p_types[:student]).
                          where(status: [Participation.statuses[:enrolled],
                                         Participation.statuses[:pre_enrolled]]).
                                                      order('people.name').each do |p|
      enrolls.append [count, p.person.name, p.person.email + "\n\n", p.person.phone_numbers.map {|pn| PhoneNumbersHelper.phone_display(pn)}.join("\n")] + @dates.map {|d| Prawn::Text::NBSP * 13}
      count += 1
    end

    # Adicionar linhas em branco a mais para inscrições de última hora,
    # colocar 30% a mais que os inscritos atuais
    (count * 0.30).ceil.times do
      enrolls.append(Array.new(enrolls[0].size, ' '))
    end

    gen_table enrolls, nil, {1 => 150, 2 => 170, 3 => 150}

    move_down 30
    font(@@default_font, size: 13, style: :bold) { text 'Equipe Docente' }
    move_down 10

    count = 1
    organizers = [['#', 'Nome', 'Função'] + @dates]
    @event.enrolls.where(p_type: Participation::ORGANIZER_P_TYPES).each do |p|
      organizers.append [count, p.person.name, I18n.t("participation.types.#{p.p_type}")] + @dates.map {|d| Prawn::Text::NBSP * 13}
      count += 1
    end

    gen_table organizers

  end


end
