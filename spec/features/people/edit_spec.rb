
require 'rails_helper'

describe 'Edição de pessoa' do

  before :each do
    sign_in(create :user)
  end

  it 'edita email da pessoa' do
    person = create(:person)
    visit edit_person_path(person)
    fill_in 'E-mail', with: 'novo@email.com'
    click_on 'Salvar'
    expect(page).to have_content('novo@email.com')
  end

  it 'adiciona endereço a uma pessoa que já existe' do
    person = create :person
    visit edit_person_path(person)

    address = build :address
    fill_in 'line1_1', with: address.line1
    fill_in 'city_1', with: address.city
    fill_in 'zip_1', with: address.zip
    fill_in 'state_1', with: address.state
    fill_in 'country_1', with: address.country
    click_on 'Salvar'
    expect(page).to have_content address.line1
  end

  it 'adiciona um telefone válido' do
    person = create(:person)
    visit edit_person_path(person)
    select 'Fixo', from: 'Phone type'
    fill_in 'number_1', with: '45 35755578'
    click_on 'Salvar'
    # os zeros na frente e espaços foram adicionados pelo phony_rails (ou seja, números foram normalizados)
    expect(page).to have_content('Fixo: 045 3575 5578')
  end

  it 'adiciona um telefone inválido' do
    person = create(:person)
    visit edit_person_path(person)
    fill_in 'number_1', with: '35755578' # sem DDD
    click_on 'Salvar'
    expect(page).to have_content('Número de telefone inválido')
  end

  it 'edita telefone' do
    person = create(:person)
    visit edit_person_path(person)
    select 'Fixo', from: 'Phone type'
    fill_in 'number_1', with: '45 35755566'

    click_on 'Salvar'
    # os zeros na frente e espaços foram adicionados pelo phony_rails (ou seja, números foram normalizados)
    expect(page).to have_content('Fixo: 045 3575 5566')
  end

  it 'avisa usuário em caso de conflito' do
    person = create :person
    visit edit_person_path(person)
    sleep 0.5
    in_browser(:two) do
      # como se trate de nova sessão, tem que fazer o sign_in
      sign_in(create :user, email: 'novoemail@email.com')
      visit edit_person_path(person)
      fill_in 'Nome', with: 'Novo nome da pessoa'
      click_on 'Salvar'
    end

    fill_in 'Nome', with: 'Um outro nome da pessoa'
    click_on 'Salvar'
    expect(page).to have_content('Este registro mudou enquanto você estava editando-o')
    expect(page).to have_content('era Novo nome da pessoa')
  end

end