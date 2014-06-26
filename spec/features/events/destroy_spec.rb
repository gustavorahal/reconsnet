require 'spec_helper'

describe 'Deleta evento' do

  before :each do
    sign_in(create :user)
  end

  it 'deleta um evento' do
    event = create(:event)
    visit event_path(event)
    expect(page).to have_content event.name
    click_on 'Deletar'
    expect(page).to have_content "Evento '#{event.name}' deletado com sucesso!"
  end


  it 'deleta um evento deve deletar todas as participações' do
    event = create :event
    visit event_path(event)
    expect(page).to have_content(event.name)

    create :participation, person: create(:person), event: event
    create :participation, person: create(:person), event: event
    click_on 'Deletar'
    expect(page).to have_content "Evento '#{event.name}' deletado com sucesso!"

    expect(Participation.where(event: event)).to be_empty
  end

end