require 'rails_helper'

describe 'Volunteers' do

  let(:user) { create :user }
  let(:user_admin) { create :user_admin }

  before :each do
    sign_in(user_admin)
  end

  it 'ao adicionar voluntário, role passa a ser volunteer' do
    expect(user.has_role? :volunteer).to be_falsey

    person = create :person, name: user.name, email: user.email
    user.person = person
    user.save!
    visit new_volunteer_path
    select person.name, from: 'Pessoa'
    select 'Eventos', from: 'Área de atuação'
    click_on 'Salvar'

    expect(user.has_role? :volunteer).to be_truthy
  end

  it 'ao deletar voluntário, remover role de usuário' do
    expect(user.has_role? :volunteer).to be_falsey
    # cria voluntário
    person = create :person, name: user.name, email: user.email
    user.person = person
    user.save!
    visit new_volunteer_path
    select person.name, from: 'Pessoa'
    select 'Eventos', from: 'Área de atuação'
    click_on 'Salvar'

    expect(user.has_role? :volunteer).to be_truthy

    # agora deleta
    visit volunteers_path
    find(:linkhref, volunteer_path(Volunteer.last!)).click

    expect(user.has_role? :volunteer).to be_falsey
  end

  it 'não permite adicionar a mesma pessoa 2x como voluntário' do
    person = create(:person)
    # Adiciona pessoa a primeira vez como voluntário
    visit new_volunteer_path
    select person.name, from: 'Pessoa'
    click_on 'Salvar'

    # Adiciona pessoa uma segunda vez, deve falhar
    visit new_volunteer_path
    select person.name, from: 'Pessoa'
    click_on 'Salvar'
    expect(page).to have_content 'Favor corrigir o(s) erro(s) abaixo'
    expect(page).to have_content person.name
    expect(page).to have_content 'já está em uso'
  end

end
