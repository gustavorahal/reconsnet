
require 'rails_helper'

feature 'Usuário cria novo contato TMK' do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end

  scenario 'usuário na página inicial' do
    # gera dados do banco
    quem_fez_contato = create :person, email: user.email
    contatado = create :person
    evento = create :event

    visit root_path
    click_on 'TMK'
    find(:linkhref, new_tmk_path).click

    ui_new_tmk(contatado, quem_fez_contato, evento)

    expect(page).to have_content contatado.name
    #expect(page).to have_content quem_fez_contato.name
    #expect(page).to have_content 'Telefônico'
    expect(page).to have_content evento.name
    expect(page).to have_content 'Pessoa interessada'

  end
end