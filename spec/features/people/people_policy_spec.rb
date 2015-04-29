require 'rails_helper'

feature 'Política de acesso a pessoas' do

  scenario 'anônimo NÃO acessa pessoa(s)' do
    person = create :person

    # acesso a pessoas
    visit people_path
    expect(page).to have_content 'Para continuar, faça login ou crie uma conta.'

    # acesso a uma pessoa
    visit person_path(person)
    expect(page).to have_content 'Para continuar, faça login ou crie uma conta.'
  end


  scenario 'usuário NÃO acessa pessoa(s)' do
    person = create :person
    sign_in(create :user)

    # acesso a pessoas
    visit people_path
    expect(page).to have_content 'Você não tem autorização para realizar esta ação.'

    # acesso a uma pessoa
    visit person_path(person)
    expect(page).to have_content 'Você não tem autorização para realizar esta ação.'
  end


  scenario 'voluntário acessa pessoas' do
    volunteer = create :volunteer
    person = volunteer.person
    sign_in(create(:user_volunteer_role, person: person, email: person.email))

    # acesso a pessoas
    visit people_path
    expect(page).to have_content person.name
    expect(page).to have_content person.email

    # # acesso a uma pessoa
    visit person_path(person)
    expect(page).to have_content person.name
    expect(page).to have_content person.email
  end

end