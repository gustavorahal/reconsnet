
require 'rails_helper'

feature 'Versionamento para pessoa', versioning: true do

  let(:user) { create :user_admin }

  let(:new_person) {
    person = build(:person)
    visit people_path
    click_on 'Nova pessoa'
    fill_in 'Nome', with: person.name
    fill_in 'E-mail', with: person.email
    click_on 'Salvar'
    Person.last!
  }

  before :each do
    sign_in(user)
  end


  scenario 'pessoa é adicionada pelo sistema' do

    person = create(:person)

    # Checar se na página da pessoa aparece a alteração
    visit versions_person_path(person)
    expect(page).to have_content("Alterações relacionadas a pessoa #{person.name}")
    expect(page).to have_content("Sistema adicionou pessoa")
    expect(page).to have_content("Nome &ltvazio&gt #{person.name}")
    expect(page).to have_content("E-mail &ltvazio&gt #{person.email}")

    # Checar se no página de alterações globais tb aparece
    visit versions_path
    expect(page).to have_content("Sistema adicionou pessoa")
    expect(page).to have_content("Nome &ltvazio&gt #{person.name}")
    expect(page).to have_content("E-mail &ltvazio&gt #{person.email}")
  end

  scenario 'pessoa é adicionada por usuário logado' do

    person = new_person

    # Checar se na página da pessoa aparece a alteração
    visit versions_person_path(person)
    expect(page).to have_content("Alterações relacionadas a pessoa #{person.name}")
    expect(page).to have_content("#{user.name} adicionou pessoa")
    expect(page).to have_content("Nome &ltvazio&gt #{person.name}")
    expect(page).to have_content("E-mail &ltvazio&gt #{person.email}")

    # Checar se no página de alterações globais tb aparece
    visit versions_path
    expect(page).to have_content("#{user.name} adicionou pessoa")
    expect(page).to have_content("Nome &ltvazio&gt #{person.name}")
    expect(page).to have_content("E-mail &ltvazio&gt #{person.email}")
  end


  scenario 'pessoa é deletada por usuário logado' do
    person = create(:person)
    person_name = person.name
    visit person_path(person)
    click_on 'Deletar'

    visit versions_path
    expect(page).to have_content("#{user.name} excluiu pessoa #{person_name}")
  end

  scenario 'pessoa é editada por usuário logado' do
    person = create(:person)
    visit edit_person_path(person)
    fill_in 'Ocupação', with: 'Psicólogo'
    click_on 'Salvar'

    visit versions_person_path(person)
    expect(page).to have_content("#{user.name} editou pessoa")
    expect(page).to have_content("Ocupação &ltvazio&gt #{person.occupation}")

    visit versions_path
    expect(page).to have_content("#{user.name} editou pessoa #{person.name}")
    expect(page).to have_content("Ocupação &ltvazio&gt #{person.occupation}")
  end


  scenario 'telefone é adicionado por usuário logado' do
    person = new_person
    visit edit_person_path(person)
    select 'Fixo', from: 'Tipo'
    fill_in 'number_1', with: '45 35755578'
    click_on 'Salvar'
    pn = PhoneNumber.last!

    visit versions_person_path(person)
    expect(page).to have_content("#{user.name} adicionou telefone")
    expect(page).to have_content("Número &ltvazio&gt #{pn.number}")

    visit versions_path
    expect(page).to have_content("#{user.name} adicionou telefone de #{person.name}")
    expect(page).to have_content("Número &ltvazio&gt #{pn.number}")
  end

  scenario 'telefone é editado por usuário logado' do
    person = new_person

    # adição
    orig_number = '+554535755578'
    visit edit_person_path(person)
    select 'Fixo', from: 'Tipo'
    fill_in 'number_1', with: orig_number
    click_on 'Salvar'

    # edição
    new_number = '+554535777777'
    visit edit_person_path(person)
    fill_in 'number_1', with: new_number
    click_on 'Salvar'

    visit versions_person_path(person)
    expect(page).to have_content("#{user.name} editou telefone #{orig_number}")
    expect(page).to have_content("Número #{orig_number} #{new_number}")

    visit versions_path
    expect(page).to have_content("#{user.name} editou telefone #{orig_number} de #{person.name}")
    expect(page).to have_content("Número #{orig_number} #{new_number}")
  end

  scenario 'endereço é adicionado por usuário logado' do
    person = create :person
    address = build :address

    visit edit_person_path(person)
    fill_in 'line1_1', with: address.line1
    fill_in 'city_1', with: address.city
    fill_in 'zip_1', with: address.zip
    fill_in 'state_1', with: address.state
    fill_in 'country_1', with: address.country
    click_on 'Salvar'

    visit versions_person_path(person)
    expect(page).to have_content("#{user.name} adicionou endereço")
    expect(page).to have_content("Endereço &ltvazio&gt #{address.line1}")

    visit versions_path
    expect(page).to have_content("#{user.name} adicionou endereço de #{person.name}")
    expect(page).to have_content("Endereço &ltvazio&gt #{address.line1}")
  end

  scenario 'endereço é editado por usuário logado' do
    person = create(:person)
    address = create :address, addressable_id: person.id, addressable_type: 'Person'
    orig_address = address.line1
    new_address = 'Rua das Flores'

    visit edit_person_path(person)
    fill_in 'line1_1', with: new_address
    click_on 'Salvar'

    visit versions_person_path(person)
    expect(page).to have_content("#{user.name} editou endereço #{address.label}")
    expect(page).to have_content("Endereço #{orig_address} #{new_address}")

    visit versions_path
    expect(page).to have_content("#{user.name} editou endereço #{address.label} de #{person.name}")
    expect(page).to have_content("Endereço #{orig_address} #{new_address}")
  end

  scenario 'endereço é deletado pelo sistema' do
    person = create(:person)
    address = create :address, addressable_id: person.id, addressable_type: 'Person'
    address_line1 = address.line1
    label = address.label
    address.destroy

    visit versions_person_path(person)
    expect(page).to have_content("Sistema excluiu endereço #{label}")
    expect(page).to have_content("Endereço #{address_line1} &ltvazio&gt")

    visit versions_path
    expect(page).to have_content("Sistema excluiu endereço #{label} de #{person.name}")
    expect(page).to have_content("Endereço #{address_line1} &ltvazio&gt")
  end

end