require 'rails_helper'

describe 'Tmk' do

  before :each do
    @signed_in_user = create :user
    sign_in(@signed_in_user)
  end


  def novo_tmk(contatado, quem_fez_contato, evento)
    visit tmks_path
    click_on 'Adicionar'

    select contatado.name, from: 'Contatado'
    select quem_fez_contato.name, from: 'Quem fez contato'
    select 'Telefônico', from: 'Tipo de contato'
    select evento.name, from: 'Evento'
    fill_in 'Notas', with: 'Pessoa interessada'
    click_on 'Salvar'
  end

  it 'adiciona novo tmk' do
    quem_fez_contato = create :person, email: @signed_in_user.email
    contatado = create :person
    evento = create :event
    novo_tmk(contatado, quem_fez_contato, evento)

    expect(page).to have_content contatado.name
    expect(page).to have_content quem_fez_contato.name
    expect(page).to have_content 'Telefônico'
    expect(page).to have_content evento.name
    expect(page).to have_content 'Pessoa interessada'
  end

  it 'deleta um contato tmk' do
    quem_fez_contato = create :person, email: @signed_in_user.email
    contatado = create :person
    evento = create :event
    novo_tmk(contatado, quem_fez_contato, evento)

    expect(page).to have_content contatado.name

    # Btn de delete do tmk
    find("//a[@href=\"#{tmk_path(Tmk.take)}\"]").click

    expect(page).to_not have_content contatado.name
  end


end