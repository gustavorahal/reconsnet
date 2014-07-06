require 'rails_helper'

describe 'Visualiza Pessoa' do

  before :each do
    sign_in(create :user)
  end

  it 'visualiza participações em eventos' do
    participation = create(:participation)
    visit person_path(participation.person)
    expect(page).to have_content(participation.event.name)
    expect(page).to have_content(participation.participation_type)
  end

end
