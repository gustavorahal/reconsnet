require 'rails_helper'

feature 'Adição de pessoas' do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end


  scenario 'adiciona pessoa' do
    person = build(:person)
    visit people_path
    click_on 'Nova pessoa'
    fill_in 'Nome', with: person.name
    fill_in 'E-mail', with: person.email
    click_on 'Salvar'

    expect(page).to have_content person.email
    expect(page).to have_content person.name
  end

  scenario 'adiciona pessoa junto com seu endereço' do
    person = build :person
    address = build :address
    visit people_path
    click_on 'Nova pessoa'
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
    expect(page).to have_content("#{address.city} - #{address.state}")
  end


  scenario 'adiciona pessoa somente com nome de cidade em seu endereço' do
    person = build :person
    address = build :address
    visit people_path

    click_on 'Nova pessoa'
    fill_in 'Nome', with: person.name
    fill_in 'E-mail', with: person.email
    fill_in 'city_1', with: address.city
    fill_in 'state_1', with: address.state
    click_on 'Salvar'

    expect(page).to have_content("#{address.city} - #{address.state}")
  end


  scenario 'NÃO adiciona se nome ou email já existe' do
    person = create :person

    visit new_person_path
    fill_in 'Nome', with: person.name
    click_on 'Salvar'
    expect(page).to have_content 'Nome já está em uso'

    visit new_person_path
    fill_in 'E-mail', with: person.email
    click_on 'Salvar'
    expect(page).to have_content 'E-mail já está em uso'

  end


end