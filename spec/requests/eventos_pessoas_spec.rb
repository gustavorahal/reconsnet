require 'spec_helper'

describe 'EventosPessoas' do

  it 'adiciona participante' do
    evento = create :evento
    pessoa = create :pessoa
    visit new_participacao_path(evento.id)
    select pessoa.nome, from: 'Pessoa'
    select 'Inscrito', from: 'Status'
    select 'Professor', from: 'Tipo participacao'
  end

end