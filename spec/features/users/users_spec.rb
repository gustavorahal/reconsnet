require 'rails_helper'

describe 'Users' do

  # before :each do
  #   sign_in(create :user)
  # end

  it 'associa novo usuário com pessoa que já existe' do
    person = create :person

    visit root_path

    click_on 'Criar conta'
    fill_in 'Nome', with: person.name
    fill_in 'Email', with: person.email
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    click_on 'Criar'

    expect(User.last.person).to eq person
  end


end