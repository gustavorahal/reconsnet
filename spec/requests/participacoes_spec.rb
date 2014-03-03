require 'spec_helper'

describe 'Participacoes' do

  it 'adiciona participante' do
    evento = create :evento
    pessoa = create :pessoa
    visit new_evento_participacao_path(evento.id)
    select pessoa.nome, from: 'Pessoa'
    select 'Inscrito', from: 'Status'
    select 'Professor', from: 'Tipo'
  end

end