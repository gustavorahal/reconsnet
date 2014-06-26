require 'spec_helper'

describe 'Participations' do

  before :each do
    sign_in(create :user)
  end

  it 'adiciona participante' do
    event = create :event
    person = create :person
    visit new_event_participation_path(event.id)
    select person.name, from: 'Pessoa'
    select 'Inscrito', from: 'Status'
    select 'Professor', from: 'Tipo de participação'
    click_on 'Salvar'
  end

end