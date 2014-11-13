
require 'rails_helper'

feature 'Usuário edita uma atividade' do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end

  scenario 'página da atividade esta aberta' do
    activity = create :activity
    visit activity_path(activity)

    click_on 'Editar'

    fill_in 'Nome', with: 'Meu novo nome'

    click_on 'Salvar'

    expect(page).to have_content 'Meu novo nome'
  end
end