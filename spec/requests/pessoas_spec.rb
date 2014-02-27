require 'spec_helper'

describe 'Pessoas' do

  it 'adiciona nova pessoa' do
    pessoa = build(:pessoa)
    visit pessoas_path
    click_on 'Adicionar'
    fill_in 'Nome', with: pessoa.nome
    fill_in 'E-mail', with: pessoa.email
    click_on 'Salvar'

  end

  it 'edita email da pessoa' do
    pessoa = create(:pessoa)
    visit pessoas_path
    page.should have_content(pessoa.email)
    click_on 'Editar'
    fill_in 'E-mail', with: 'novo@email.com'
    click_on 'Salvar'
    page.should have_content('novo@email.com')
  end

  it 'deleta uma pessoa' do
    pessoa = create(:pessoa)
    visit pessoas_path
    page.should have_content(pessoa.nome)
    click_on 'Deletar'
    page.should_not have_content(pessoa.nome)
  end

  it 'visualiza participações em evento' do
    evento_pessoa = create(:evento_pessoa)
    visit pessoas_path
    click_on 'Info'
    page.should have_content(evento_pessoa.evento.nome)
    page.should have_content(evento_pessoa.tipo_participacao)
  end


end
