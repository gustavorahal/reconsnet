require 'rails_helper'

feature 'Users' do

  # before :each do
  #   sign_in(create :user)
  # end


  scenario 'associa novo usuário com pessoa que já existe' do
    person = create :person

    ### FIXME: Habilitar novamente quando Criar Conta voltar a ficar habilitado
    #visit root_path
    #click_on 'Criar conta'
    visit 'users/sign_up'

    fill_in 'Nome', with: person.name
    fill_in 'Email', with: person.email
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    click_on 'Criar'

    expect(User.last.person).to eq person
  end

  scenario 'adiciona papel de Administrador e Voluntário a usuário' do
    user = create :user
    expect(user.has_role?(:admin)).to be false
    expect(user.has_role?(:volunteer)).to be false
    sign_in(create :user_admin)

    visit edit_user_path(user)
    check 'Administrador'
    check 'Voluntário'
    click_on 'Salvar'

    expect(user.has_role?(:admin)).to be true
    expect(user.has_role?(:volunteer)).to be true
  end

end