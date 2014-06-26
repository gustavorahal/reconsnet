require 'spec_helper'

describe 'Events' do

  before :each do
    sign_in(create :user)
  end

  it 'adiciona novo evento' do
    event = build(:event)
    visit events_path
    click_on 'Adicionar'
    fill_in 'Nome', with: event.name
    select event.event_type, from: 'Tipo de evento'
    fill_in 'Início', with: event.start
    fill_in 'Fim', with: event.finish
    click_on 'Salvar'

    expect(current_path).to eq(events_path)

    expect(page).to have_content("Evento '#{event.name}' adicionado com sucesso!")
  end


end
