require 'spec_helper'

describe 'Participations' do

  it 'adiciona participante' do
    event = create :event
    person = create :person
    visit new_event_participation_path(event.id)
    select person.name, from: 'Person'
    select 'Inscrito', from: 'Status'
    select 'Professor', from: 'Participation type'
  end

end