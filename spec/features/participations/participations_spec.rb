require 'rails_helper'

feature 'Participations' do

  before :each do
    sign_in(create :user_admin)
  end

  scenario 'adiciona participante' do
    event = create :event
    person = create :person
    visit new_event_participation_path(event.id)
    select person.name, from: 'Pessoa'
    select 'Inscrito', from: 'Status'
    select 'Professor', from: 'Tipo de participação'
    click_on 'Salvar'
  end

  scenario 'visualiza lista de emails de participantes de um evento' do
    event = create :event
    part1 = create :participation, event: event
    part2 = create :participation, event: event
    visit event_path(event)
    click_on 'E-mails'

    # Expected format: My name <myemail@company.com>
    expect(page).to have_content "#{part1.person.name} <#{part1.person.email}>"
    expect(page).to have_content "#{part2.person.name} <#{part2.person.email}>"
  end

end