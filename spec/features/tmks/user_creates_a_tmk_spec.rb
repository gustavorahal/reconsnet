
require 'rails_helper'

feature 'Usuário cria novo contato TMK' do

  before :each do
    @signed_in_user = create :user
    sign_in @signed_in_user
  end

  scenario 'usuário na página inicial' do
    # gera dados do banco
    quem_fez_contato = create :person, email: @signed_in_user.email
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