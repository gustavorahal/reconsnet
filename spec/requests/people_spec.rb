require 'spec_helper'

describe 'Persons' do

  it 'adiciona nova pessoa' do
    person = build(:person)
    visit people_path
    click_on 'Adicionar'
    fill_in 'Nome', with: person.name
    fill_in 'E-mail', with: person.email
    click_on 'Salvar'
    page.should have_content("Pessoa '#{person.name}' adicionada com sucesso!")
  end

  it 'edita email da person' do
    person = create(:person)
    visit edit_person_path(person)
    fill_in 'E-mail', with: 'novo@email.com'
    click_on 'Salvar'
    page.should have_content('novo@email.com')
    page.should have_content("Pessoa '#{person.name}' atualizada com sucesso!")
  end


  it 'adiciona um telefone fixo e celular válido' do
    person = create(:person)
    visit edit_person_path(person)
    fill_in 'Telefone Fixo', with: '45 35755578'
    fill_in 'Telefone Celular', with: '45 99440907'
    click_on 'Salvar'
    # os zeros na frente e espaços foram adicionados pelo phony_rails (ou seja, números foram normalizados)
    page.should have_content('Fixo: 045 3575 5578')
    page.should have_content('Cel: 045 9944 0907')
  end

  it 'adiciona um telefone fixo e celular inválido' do
    person = create(:person)
    visit edit_person_path(person)
    fill_in 'Telefone Fixo', with: '35755578' # sem DDD
    fill_in 'Telefone Celular', with: '99440907' # sem DDD
    click_on 'Salvar'
    page.should have_content('Número de telefone inválido')
  end

  it 'edita telefone fixo e celular' do
    person = create(:person)
    visit edit_person_path(person)
    fill_in 'Telefone Fixo', with: '45 35755566'
    fill_in 'Telefone Celular', with: '45 99440988'
    click_on 'Salvar'
    # os zeros na frente e espaços foram adicionados pelo phony_rails (ou seja, números foram normalizados)
    page.should have_content('Fixo: 045 3575 5566')
    page.should have_content('Cel: 045 9944 0988')
  end


  it 'adiciona pessoa junto com seu endereço' do
    person = build :person
    address = build :address
    visit people_path
    click_on 'Adicionar'
    fill_in 'Nome', with: person.name
    fill_in 'E-mail', with: person.email
    fill_in 'Endereço', with: address.line1
    fill_in 'Cidade', with: address.city
    fill_in 'CEP', with: address.zip
    select 'Paraná', from: 'Estado', :match => :first
    select 'Brasil', from: 'País', :match => :first
    click_on 'Salvar'
    page.should have_content("Pessoa '#{person.name}' adicionada com sucesso!")

    Address.where(addressable_id: Person.find_by(name: person.name).id).should exist

  end

  it 'deleta uma pessoa sem endereço' do
    person = create(:person)
    visit person_path(person)
    page.should have_content(person.name)
    click_on 'Deletar'
    page.should_not have_content(person.email)
    page.should have_content("Pessoa '#{person.name}' deletada com sucesso!")
  end

  it 'delete uma pessoa com endereço' do
    person = create :person
    person_id = person.id
    address = create :address, addressable_id: person_id, addressable_type: 'Person'
    visit person_path(person)
    page.should have_content(person.name)
    click_on 'Deletar'
    page.should_not have_content(person.email)
    page.should have_content("Pessoa '#{person.name}' deletada com sucesso!")

    Address.where(addressable_id: person_id).should_not exist
  end

  it 'adiciona endereço a uma pessoa que já existe' do
    person = create :person
    visit edit_person_path(person)

    address = build :address
    fill_in 'Endereço', with: address.line1
    fill_in 'Cidade', with: address.city
    fill_in 'CEP', with: address.zip
    select 'Paraná', from: 'Estado', :match => :first
    select 'Brasil', from: 'País', :match => :first
    click_on 'Salvar'
    page.should have_content("Pessoa '#{person.name}' atualizada com sucesso!")
  end


  it 'não pode deletar uma pessoa se participa de algum evento' do
    person = create(:person)
    create(:participation, person: person)
    visit person_path(person)
    page.should have_content(person.name)
    find_link('Deletar')[:disabled].should eq "disabled"
  end

  it 'visualiza participações em eventos' do
    participation = create(:participation)
    visit person_path(participation.person)
    page.should have_content(participation.event.name)
    page.should have_content(participation.participation_type)
  end



end
