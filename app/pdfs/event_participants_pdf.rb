

class EventParticipantsPdf < EventBasePdf


  def body

    count = 1
    participants = [['#', 'Nome', 'E-mail', 'Telefones', 'OK?']]
    @event.participations.includes(:person).order('people.name').each do |p|
      numbers = p.person.phone_numbers.map {|pn| pn.number.phony_formatted}
      participants.append [count, p.person.name, p.person.email, numbers.join(' / '), '']
      count += 1
    end

    gen_table participants, { height: 40 }

  end


end
