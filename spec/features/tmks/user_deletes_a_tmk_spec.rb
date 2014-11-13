
require 'rails_helper'

feature 'Usuário delete um contato TMK' do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end

  scenario 'página dos contatos TMK esta aberta com o contato listado' do
    quem_fez_contato = create :person, email: user.email
    contatado = create :person
    evento = create :event
    visit new_tmk_path
    ui_new_tmk(contatado, quem_fez_contato, evento)

    expect(page).to have_content contatado.name

    # Btn de delete do tmk
    find(:linkhref, tmk_path(Tmk.take)).click

    expect(page).to_not have_content contatado.name
  end
end