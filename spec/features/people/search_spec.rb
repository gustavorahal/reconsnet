
require 'rails_helper'

describe 'People search' do

  before :each do
    sign_in(create :user)
  end

  it 'busca uma pessoa que existe' do
    person1 = create :person
    person2 = create :person
    visit people_path
    expect(page).to have_content person1.name
    expect(page).to have_content person2.name

    fill_in 'query', with: person1.name
    click_on 'btn-search'
    expect(page).to have_content person1.name
    expect(page).to_not have_content person2.name
  end

  it 'busca uma pessoa que não existe' do
    person1 = create :person
    person2 = create :person
    visit people_path
    expect(page).to have_content person1.name
    expect(page).to have_content person2.name

    fill_in 'query', with: 'eu não existo'
    click_on 'btn-search'
    expect(page).to_not have_content person1.name
    expect(page).to_not have_content person2.name
  end


end