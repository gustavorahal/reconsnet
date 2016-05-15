
require 'rails_helper'

feature 'Versionamento para pessoa', versioning: true do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end


  scenario 'pessoa é adicionada' do

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


  scenario 'pessoa é deletada' do
    person = create(:person)
    person_name = person.name
    person.destroy

    visit versions_path
    expect(page).to have_content("Sistema excluiu pessoa #{person_name}")
  end

  scenario 'pessoa é editada' do
    person = create(:person)
    person.occupation = 'Psicólogo'
    person.save

    visit versions_person_path(person)
    expect(page).to have_content("Sistema editou pessoa")
    expect(page).to have_content("Ocupação &ltvazio&gt #{person.occupation}")

    visit versions_path
    expect(page).to have_content("Sistema editou pessoa #{person.name}")
    expect(page).to have_content("Ocupação &ltvazio&gt #{person.occupation}")
  end


  scenario 'telefone é adicionado' do
    person = create(:person)
    pn = create :phone_number, phonable_id: person.id, phonable_type: 'Person'

    visit versions_person_path(person)
    expect(page).to have_content("Sistema adicionou telefone")
    expect(page).to have_content("Número &ltvazio&gt #{pn.number}")

    visit versions_path
    expect(page).to have_content("Sistema adicionou telefone de #{person.name}")
    expect(page).to have_content("Número &ltvazio&gt #{pn.number}")
  end

  scenario 'telefone é editado' do
    person = create(:person)
    pn = create :phone_number, phonable_id: person.id, phonable_type: 'Person'
    orig_number = pn.number
    new_number = '+554535259999'

    pn.number = new_number
    pn.save

    visit versions_person_path(person)
    expect(page).to have_content("Sistema editou telefone #{orig_number}")
    expect(page).to have_content("Número #{orig_number} #{new_number}")

    visit versions_path
    expect(page).to have_content("Sistema editou telefone #{orig_number} de #{person.name}")
    expect(page).to have_content("Número #{orig_number} #{new_number}")
  end

  scenario 'telefone é deletado' do
    person = create(:person)
    pn = create :phone_number, phonable_id: person.id, phonable_type: 'Person'
    number = pn.number
    pn.destroy

    visit versions_person_path(person)
    expect(page).to have_content("Sistema excluiu telefone #{number}")
    expect(page).to have_content("Número #{number} &ltvazio&gt")

    visit versions_path
    expect(page).to have_content("Sistema excluiu telefone #{number} de #{person.name}")
    expect(page).to have_content("Número #{number} &ltvazio&gt")
  end

  scenario 'endereço é adicionado' do
    person = create(:person)
    address = create :address, addressable_id: person.id, addressable_type: 'Person'

    visit versions_person_path(person)
    expect(page).to have_content("Sistema adicionou endereço")
    expect(page).to have_content("Endereço &ltvazio&gt #{address.line1}")

    visit versions_path
    expect(page).to have_content("Sistema adicionou endereço de #{person.name}")
    expect(page).to have_content("Endereço &ltvazio&gt #{address.line1}")
  end

  scenario 'endereço é editado' do
    person = create(:person)
    address = create :address, addressable_id: person.id, addressable_type: 'Person'
    orig_address = address.line1
    new_address = 'Rua das Flores'

    address.line1 = new_address
    address.save

    visit versions_person_path(person)
    expect(page).to have_content("Sistema editou endereço #{address.label}")
    expect(page).to have_content("Endereço #{orig_address} #{new_address}")

    visit versions_path
    expect(page).to have_content("Sistema editou endereço #{address.label} de #{person.name}")
    expect(page).to have_content("Endereço #{orig_address} #{new_address}")
  end

  scenario 'endereço é deletado' do
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