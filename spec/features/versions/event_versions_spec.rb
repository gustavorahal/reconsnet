require 'rails_helper'

feature 'Versionamento para eventos', versioning: true do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end


  scenario 'evento é adicionado' do
    event = create :event

    visit versions_event_path(event)
    expect(page).to have_content("Alterações relacionadas ao evento #{event.name}")
    expect(page).to have_content("Sistema adicionou evento")
    expect(page).to have_content("Nome &ltvazio&gt #{event.name}")

    visit versions_path
    expect(page).to have_content("Sistema adicionou evento")
    expect(page).to have_content("Nome &ltvazio&gt #{event.name}")
  end


  scenario 'evento é deletado' do
    event = create :event
    name = event.name
    event.destroy

    visit versions_path
    expect(page).to have_content("Sistema excluiu evento #{name}")
  end

  scenario 'evento é editado' do
    event = create :event
    old_name = event.name
    new_name = 'Novo nome'
    event.name = new_name
    event.save

    visit versions_event_path(event)
    expect(page).to have_content("Sistema editou evento")
    expect(page).to have_content("Nome #{old_name} #{new_name}")

    visit versions_path
    expect(page).to have_content("Sistema editou evento #{old_name}")
    expect(page).to have_content("Nome #{old_name} #{new_name}")
  end

  scenario 'participante é adicionado e deletado a evento' do
    event = create :event
    part = create :participation, event: event
    person_name = part.person.name
    part.destroy

    visit versions_event_path(event)
    expect(page).to have_content("Sistema adicionou participação #{person_name}")
    expect(page).to have_content("Sistema excluiu participação #{person_name}")

    visit versions_path
    expect(page).to have_content("Sistema adicionou participação #{person_name} ao #{event.name}")
    expect(page).to have_content("Sistema excluiu participação #{person_name} ao #{event.name}")
  end

end
