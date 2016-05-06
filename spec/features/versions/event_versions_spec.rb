require 'rails_helper'

feature 'Versionamento para eventos', versioning: true do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end


  scenario 'evento é adicionado' do

    def check_changes(event)
      expect(page).to have_content("Sistema adicionou evento")
      expect(page).to have_content("Nome &ltvazio&gt #{event.name}")
    end

    event = create :event

    visit versions_event_path(event)
    expect(page).to have_content("Alterações relacionadas a evento #{event.name}")
    check_changes(event)

    visit versions_path
    check_changes(event)
  end


  scenario 'evento é deletado' do
    event = create :event
    name = event.name
    event.destroy

    visit versions_path
    expect(page).to have_content("Sistema excluiu evento #{name}")
  end

  scenario 'evento é editado' do

    def check_changes (old_name, new_name)
      expect(page).to have_content("Sistema editou evento #{old_name}")
      expect(page).to have_content("Nome #{old_name} #{new_name}")
    end

    event = create :event
    old_name = event.name
    new_name = 'Novo nome'
    event.name = new_name
    event.save

    visit versions_event_path(event)
    check_changes(old_name, new_name)

    visit versions_path
    check_changes(old_name, new_name)
  end

  scenario 'participante é adicionado e deletado a evento' do

    def check_changes(person_name, part_obj_name)
      expect(page).to have_content("Sistema adicionou participação")
      expect(page).to have_content("Pessoa &ltvazio&gt #{person_name}")
      expect(page).to have_content("Sistema excluiu participação #{part_obj_name}")
      expect(page).to have_content("Pessoa #{person_name} &ltvazio&gt")
    end

    event = create :event
    part = create :participation, event: event
    person_name = part.person.name
    part_obj_name = part.to_s
    part.destroy

    visit versions_event_path(event)
    check_changes(person_name, part_obj_name)

    visit versions_path
    check_changes(person_name, part_obj_name)
  end

end
