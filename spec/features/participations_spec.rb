require 'rails_helper'

describe 'Participations' do

  before :each do
    sign_in(create :user_admin)
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

  it 'visualiza lista de emails de participantes de um evento', underdev: true do
    event = create :event
    part1 = create :participation, event: event
    part2 = create :participation, event: event
    visit event_path(event)
    click_on 'E-mails'
    expect(page).to have_content part1.person.email
    expect(page).to have_content part2.person.email
  end

end