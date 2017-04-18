require 'rails_helper'

feature 'Visualiza Pessoa' do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end

  scenario 'visualiza participações em eventos' do
    participation = create(:participation)
    visit person_path(participation.person)
    expect(page).to have_content(participation.event.name)
    expect(page).to have_content(I18n.t("participation.types.#{participation.p_type}").downcase)
  end


  scenario 'visualiza número de telefone do brasil' do
    phone_number = create :phone_number, number: '554599440907'
    person = create :person, phone_numbers: [phone_number,]

    visit person_path(person)
    # por padrão não mostra +55 para brasil
    expect(page).to have_content('45 9944 0907')
    expect(page).to_not have_content('+55 45 9944 0907')
  end


  scenario 'visualiza número de telefone internacional' do
    phone_number = create :phone_number, number: '+351916592222' # Portugal
    person = create :person, phone_numbers: [phone_number,]

    visit person_path(person)
    # por padrão mostra country code se não for Brasil
    expect(page).to have_content('+351 91 659 2222')
  end

end
