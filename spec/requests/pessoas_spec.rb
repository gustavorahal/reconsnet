require 'spec_helper'

describe 'Pessoas' do

  it 'adiciona nova pessoa' do
    pessoa = build(:pessoa)
    visit pessoas_path
    click_on 'Adicionar'
    fill_in 'Nome', with: pessoa.nome
    fill_in 'E-mail', with: pessoa.email
    click_on 'Salvar'
    page.should have_content("Pessoa '#{pessoa.nome}' adicionada com sucesso!")
  end

  it 'edita email da pessoa' do
    pessoa = create(:pessoa)
    visit pessoa_path(pessoa)
    page.should have_content(pessoa.email)
    click_on 'Editar'
    fill_in 'E-mail', with: 'novo@email.com'
    click_on 'Salvar'
    page.should have_content('novo@email.com')
    page.should have_content("Pessoa '#{pessoa.nome}' atualizada com sucesso!")
  end

  it 'deleta uma pessoa' do
    pessoa = create(:pessoa)
    visit pessoa_path(pessoa)
    page.should have_content(pessoa.nome)
    click_on 'Deletar'
    page.should_not have_content(pessoa.email)
    page.should have_content("Pessoa '#{pessoa.nome}' deletada com sucesso!")
  end

  it 'não pode deletar uma pessoa se participa de eventos' do
    pessoa = create(:pessoa)
    create(:participacao, pessoa: @pessoa)
    visit pessoa_path(pessoa)
    page.should have_content(pessoa.nome)
    click_on 'Deletar'
    page.should have_content('Esta pessoa tem participação em eventos, não pode ser deletada')
  end

  it 'visualiza participações em evento' do
    participacao = create(:participacao)
    visit pessoa_path(participacao.pessoa)
    page.should have_content(participacao.evento.nome)
    page.should have_content(participacao.tipo)
  end


end
