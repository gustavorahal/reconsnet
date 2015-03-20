require 'rails_helper'

describe 'Events' do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end

  it 'adiciona novo evento' do
    event = build(:event)
    visit events_path

    click_on 'Novo evento'

    select event.activity.name, from: 'Atividade'
    fill_in 'Nome', with: event.name
    select_datetime(event.start, from: 'Início')
    select_datetime(event.finish, from: 'Fim')
    click_on 'Salvar'

    event_persisted = Event.take
    expect(current_path).to eq event_path(event_persisted)
    expect(event_persisted.start.day).to eq(event.start.day)
    expect(event_persisted.finish.day).to eq(event.finish.day)
  end


end
