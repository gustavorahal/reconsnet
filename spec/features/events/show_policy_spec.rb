require 'rails_helper'


feature 'Mostrar partes da página de eventos dependendo do papel do usuário logado' do

  context 'para um visitante' do

    scenario 'NÃO mostrar participações, pendências, tmks e btn de ações' do
      user = create :user
      sign_in user

      person = create :person
      event = create :event
      create :participation, person: person, event: event

      visit event_path(event)
      expect(page).to_not have_content 'Participantes'
      expect(page).to_not have_content 'Pendências'
      expect(page).to_not have_content 'TMKs'

      expect(page).to_not have_link('Editar', href: edit_event_path(event))
      expect(page).to_not have_link('Deletar', href: event_path(event))
      expect(page).to_not have_button 'Arquivar'
    end

  end



  context 'para um voluntário' do

    scenario 'mostrar participações, pendências, tmks' do
      user = create :user_volunteer_role
      sign_in user

      person = create :person
      event = create :event
      create :participation, person: person, event: event

      visit event_path(event)

      expect(page).to have_content 'Participantes'
      expect(page).to have_content 'Pendências'
      expect(page).to have_content 'TMKs'

      expect(page).to_not have_link('Editar', href: edit_event_path(event))
      expect(page).to_not have_link('Deletar', href: event_path(event))
      expect(page).to_not have_button 'Arquivar'
    end

  end


  context 'para um voluntário de eventos' do

    scenario 'mostrar participações, pendências, tmks e btn de ações' do

      user = create :user_event_manager_role
      sign_in user

      person = create :person
      event = create :event
      create :participation, person: person, event: event

      visit event_path(event)

      expect(page).to have_content 'Participantes'
      expect(page).to have_content 'Pendências'
      expect(page).to have_content 'TMKs'

      expect(page).to have_link('Editar', href: edit_event_path(event))
      expect(page).to have_link('Deletar', href: event_path(event))
      expect(page).to have_button 'Arquivar'

    end

  end


end
