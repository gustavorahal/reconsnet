require 'rails_helper'

describe 'Events' do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end

  it 'adiciona novo evento' do
    event = build(:event)
    visit events_path
    find(:linkhref, new_event_path).click
    select event.activity.name, from: 'Atividade'
    fill_in 'Nome', with: event.name
    fill_in 'Início', with: event.start
    fill_in 'Fim', with: event.finish
    click_on 'Salvar'

    expect(current_path).to eq event_path(Event.take)
  end


end
