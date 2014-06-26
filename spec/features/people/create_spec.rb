require 'spec_helper'

describe 'Create person' do

  before :each do
    sign_in(create :user)
  end


  it 'adiciona pessoa' do
    person = build(:person)
    visit people_path
    click_on 'Adicionar'
    fill_in 'Nome', with: person.name
    fill_in 'E-mail', with: person.email
    click_on 'Salvar'

    expect(page).to have_content person.email
    expect(page).to have_content person.name
  end

  it 'adiciona pessoa junto com seu endereço' do
    person = build :person
    address = build :address
    visit people_path
    click_on 'Adicionar'
    fill_in 'Nome', with: person.name
    fill_in 'E-mail', with: person.email
    fill_in 'line1_1', with: address.line1
    fill_in 'city_1', with: address.city
    fill_in 'zip_1', with: address.zip
    fill_in 'state_1', with: address.state
    fill_in 'country_1', with: address.country
    click_on 'Salvar'

    expect(page).to have_content(person.email)
    expect(page).to have_content(person.name)
    expect(page).to have_content(address.line1)
  end




end