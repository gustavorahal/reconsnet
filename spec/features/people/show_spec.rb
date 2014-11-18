require 'rails_helper'

describe 'Visualiza Pessoa' do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end

  it 'visualiza participações em eventos' do
    participation = create(:participation)
    visit person_path(participation.person)
    expect(page).to have_content(participation.event.name)
    expect(page).to have_content(participation.participation_type.downcase)
  end

end
