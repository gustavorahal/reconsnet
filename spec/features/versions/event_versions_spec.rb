require 'rails_helper'

feature 'Versionamento para eventos', versioning: true do

  let(:user) { create :user_admin }

  # Create an activity as the logged in user so we can test if versions is tracking
  # the author of the changes
  let(:new_event) {
    event = build(:event)
    visit events_path
    click_on 'Novo evento'
    select event.activity.name, from: 'Atividade'
    fill_in 'Nome', with: event.name
    select_datetime(event.start, from: 'Início')
    select_datetime(event.finish, from: 'Fim')
    click_on 'Salvar'
    Event.last!
  }

  before :each do
    sign_in(user)
  end


  scenario 'evento é adicionado pelo sistema' do
    event = create :event

    visit versions_event_path(event)
    expect(page).to have_content("Alterações relacionadas ao evento #{event.name}")
    expect(page).to have_content("Sistema adicionou evento")
    expect(page).to have_content("Nome &ltvazio&gt #{event.name}")

    visit versions_path
    expect(page).to have_content("Sistema adicionou evento")
    expect(page).to have_content("Nome &ltvazio&gt #{event.name}")
  end

  scenario 'evento é adicionado por usuário logado' do
    event = new_event

    visit versions_event_path(event)
    expect(page).to have_content("Alterações relacionadas ao evento #{event.name}")
    expect(page).to have_content("#{user.name} adicionou evento")
    expect(page).to have_content("Nome &ltvazio&gt #{event.name}")

    visit versions_path
    expect(page).to have_content("#{user.name} adicionou evento")
    expect(page).to have_content("Nome &ltvazio&gt #{event.name}")
  end

  scenario 'evento é deletado por usuário logado' do
    event = new_event
    name = event.name
    event_path(event)
    click_on 'Deletar'

    visit versions_path
    expect(page).to have_content("#{user.name} excluiu evento #{name}")
  end

  scenario 'evento é editado por usuário logado' do
    event = new_event
    old_name = event.name
    new_name = 'Novo nome'
    visit edit_event_path(event)
    fill_in 'Nome', with: new_name
    click_on 'Salvar'

    visit versions_event_path(event)
    expect(page).to have_content("#{user.name} editou evento")
    expect(page).to have_content("Nome #{old_name} #{new_name}")

    visit versions_path
    expect(page).to have_content("#{user.name} editou evento #{old_name}")
    expect(page).to have_content("Nome #{old_name} #{new_name}")
  end

  scenario 'participante é adicionado e deletado a evento por usuário logado' do
    event = new_event
    person = create :person
    person_name = person.name
    visit new_event_participation_path(event.id)
    select person_name, from: 'Pessoa'
    select 'Inscrito', from: 'Status'
    select 'Aluno', from: 'Tipo de participação'
    click_on 'Salvar'
    part = Participation.last!

    # deleta participante
    find(:linkhref, event_participation_path(event, part)).click

    visit versions_event_path(event)
    expect(page).to have_content("#{user.name} adicionou participação #{person_name}")
    expect(page).to have_content("#{user.name} excluiu participação #{person_name}")

    visit versions_path
    expect(page).to have_content("#{user.name} adicionou participação #{person_name} ao #{event.name}")
    expect(page).to have_content("#{user.name} excluiu participação #{person_name} ao #{event.name}")
  end

end
