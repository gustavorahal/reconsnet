require 'rails_helper'

feature 'Participations' do

  before :each do
    sign_in(create :user_admin)
  end

  scenario 'adição de Docente a Evento' do
    person = create :person
    user = create :user, person: person
    event = create :event
    visit new_event_participation_path(event.id)
    select person.name, from: 'Pessoa'
    select 'Inscrito', from: 'Status'
    select 'Professor', from: 'Tipo de participação'
    click_on 'Salvar'

    expect(person.user.has_role?(:event_admin, event)).to be true
  end


  scenario 'adição de Participante a Evento' do
    person = create :person
    user = create :user, person: person
    event = create :event
    visit new_event_participation_path(event.id)
    select person.name, from: 'Pessoa'
    select 'Inscrito', from: 'Status'
    select 'Aluno', from: 'Tipo de participação'
    click_on 'Salvar'

    expect(person.user.has_role?(:participant, event)).to be true
  end


  scenario 'apenas adição de participante deve mostrar btn "Salvar e adicionar outra"' do

    # Mostra na adição de participante
    person = create :person
    user = create :user, person: person
    event = create :event
    visit new_event_participation_path(event.id)
    expect(page).to have_button 'Salvar e adicionar outra'

    # Não mostra na edição de participante
    event = create :event
    part = create :participation, event: event
    visit edit_event_participation_path(event.id, part.id)
    expect(page).to_not have_button 'Salvar e adicionar outra'
  end

  scenario 'deleção de Participante em Evento' do
    # Add participation (goes through controller so roles are added acordingly)
    person = create :person
    user = create :user, person: person
    event = create :event
    visit new_event_participation_path(event.id)
    select person.name, from: 'Pessoa'
    select 'Inscrito', from: 'Status'
    select 'Aluno', from: 'Tipo de participação'
    click_on 'Salvar'

    part = Participation.first
    expect(part.person.id).to be person.id

    visit event_path(event)

    expect(page).to have_content "#{person.name}"
    expect(person.user.has_role?(:participant, event)).to be true

    find(:linkhref, event_participation_path(event, part)).click

    expect(page).to_not have_content "#{person.name}"
    expect(person.user.has_role?(:participant, event)).to be false
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