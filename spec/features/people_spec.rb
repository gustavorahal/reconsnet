require 'spec_helper'

describe 'Persons' do

  before :each do
    sign_in(create :user)
  end

  it 'adiciona nova pessoa' do
    person = build(:person)
    visit people_path
    click_on 'Adicionar'
    fill_in 'Nome', with: person.name
    fill_in 'E-mail', with: person.email
    click_on 'Salvar'

    expect(page).to have_content person.email
    expect(page).to have_content person.name
  end

  it 'edita email da pessoa' do
    person = create(:person)
    visit edit_person_path(person)
    fill_in 'E-mail', with: 'novo@email.com'
    click_on 'Salvar'
    expect(page).to have_content('novo@email.com')
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

  it 'deleta uma pessoa sem endereço' do
    person = create(:person)
    visit person_path(person)
    expect(page).to have_content(person.name)
    click_on 'Deletar'
    expect(page).to_not have_content(person.email)
    expect(page).to_not have_content(person.name)
  end

  it 'delete uma pessoa com endereço' do
    person = create :person
    person_id = person.id
    address = create :address, addressable_id: person_id, addressable_type: 'Person'
    visit person_path(person)
    expect(page).to have_content(person.name)
    click_on 'Deletar'
    expect(page).to_not have_content(person.email)
    expect(page).to_not have_content(person.name)

    expect(Address.where(addressable_id: person_id)).to_not exist
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


  it 'busca uma pessoa', underdev: true do
    person1 = create :person
    person2 = create :person
    visit people_path
    expect(page).to have_content person1.name
    expect(page).to have_content person2.name

    fill_in 'query', with: person1.name
    click_on 'btn-search'
    expect(page).to have_content person1.name
    expect(page).to_not have_content person2.name

    # busca uma pessoa que não existe
    fill_in 'query', with: 'eu não existo'
    click_on 'btn-search'
    expect(page).to_not have_content person1.name
    expect(page).to_not have_content person2.name
  end


  it 'não pode deletar uma pessoa se participa de algum evento' do
    person = create(:person)
    create(:participation, person: person)
    visit person_path(person)
    expect(page).to have_content(person.name)
    expect(find_link('Deletar')[:disabled]).to eq 'disabled'
  end

  it 'visualiza participações em eventos' do
    participation = create(:participation)
    visit person_path(participation.person)
    expect(page).to have_content(participation.event.name)
    expect(page).to have_content(participation.participation_type)
  end

  it 'avisa usuário em caso de conflito', underdev: true do
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
