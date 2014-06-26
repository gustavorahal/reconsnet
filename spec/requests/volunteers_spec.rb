require 'spec_helper'

describe 'Volunteers' do

  before :each do
    sign_in(create :user)
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
