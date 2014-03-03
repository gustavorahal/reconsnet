require 'spec_helper'

describe 'Eventos' do

  it 'adiciona novo evento' do
    evento = build(:evento)
    visit eventos_path
    click_on 'Adicionar'
    fill_in 'Nome', with: evento.nome
    select evento.tipo, from: 'Tipo'
    fill_in 'Inicio', with: evento.inicio
    fill_in 'Fim', with: evento.fim
    click_on 'Salvar'

    current_path.should eq(eventos_path)

    page.should have_content("Evento '#{evento.nome}' adicionado com sucesso!")
  end


  it 'deleta um evento' do
    evento = create(:evento)
    visit evento_path(evento)
    page.should have_content(evento.nome)
    click_on 'Deletar'
    page.should have_content("Evento '#{evento.nome}' deletado com sucesso!")
  end


  it 'altera um evento' do
    evento = create(:evento)
    visit evento_path(evento)
    click_on 'Editar'
    find_field('Nome').value().should eq(evento.nome)
    desc_txt = 'Uma nova descrição'
    fill_in 'Descricao', with: desc_txt
    click_on 'Salvar'
    page.should have_content("Evento '#{evento.nome}' atualizado com sucesso!")

  end


end
