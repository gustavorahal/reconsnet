require 'rails_helper'

describe 'Volunteers' do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
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

  it 'mudança de área de atuação deve mudar usuário do sistema' do
    # Criar pessoa e voluntário fazendo os links necessários entre um e outro
    person = create(:person)
    user.person = person
    user.save
    vol = create :volunteer, person: person

    visit edit_volunteer_path(vol)
    select 'Eventos', from: 'Área de atuação'
    click_on 'Salvar'

    # confirma que user tem um novo grupo setado
    user.reload
    expect(user.group).to eq('Eventos')
  end

end
