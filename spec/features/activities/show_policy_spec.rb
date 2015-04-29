require 'rails_helper'


feature 'Mostrar partes da página de atividades dependendo do papel do usuário logado' do

  context 'para um visitante' do

    scenario 'NÃO mostrar btns de editar e deletar' do
      user = create :user
      sign_in user

      activity = create :activity
      visit activity_path(activity)

      expect(page).to_not have_link('Editar', href: edit_activity_path(activity))
      expect(page).to_not have_link('Deletar', href: activity_path(activity))
    end

  end



  context 'para um voluntário' do

    scenario 'mostrar btns de editar e deletar' do
      user = create :user_volunteer_role
      sign_in user

      activity = create :activity
      visit activity_path(activity)

      expect(page).to have_link('Editar', href: edit_activity_path(activity))
      expect(page).to have_link('Deletar', href: activity_path(activity))
    end

  end



end
