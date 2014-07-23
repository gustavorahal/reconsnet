
require 'rails_helper'

feature 'Usuário cria uma atividade' do

  before :each do
    sign_in(create :user)
  end

  scenario 'usuário na página inicial' do
    visit root_path
    # Clica no botão de adicionar do menu "Atividades"
    find(:linkhref, new_activity_path).click
    fill_in 'Nome', with: 'Nova atividade'
    fill_in 'Sumário', with: 'Esta nova atividade é bastante interessante'

    click_on 'Salvar'

    expect(page).to have_content 'Atividade Nova atividade'
    expect(page).to have_content 'Eventos desta atividade'
  end
end