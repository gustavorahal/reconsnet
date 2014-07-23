
require 'rails_helper'

feature 'Usuário edita uma atividade' do

  before :each do
    sign_in(create :user)
  end

  scenario 'página da atividade esta aberta' do
    activity = create :activity
    visit activity_path(activity)

    click_on 'Editar'

    fill_in 'Nome', with: 'Meu novo nome'

    click_on 'Salvar'

    expect(page).to have_content 'Atividade Meu novo nome'
  end
end