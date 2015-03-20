
require 'rails_helper'

feature 'Usuário cria uma atividade' do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end

  scenario 'a partir da página de atividades' do
    visit activities_path

    click_on 'Nova atividade'

    fill_in 'Nome', with: 'Nova atividade'
    fill_in 'Sumário', with: 'Esta nova atividade é bastante interessante'

    click_on 'Salvar'

    expect(page).to have_content 'Nova atividade'
    expect(page).to have_content 'Eventos'
  end
end