require 'spec_helper'

describe 'Persons' do

  it 'adiciona nova person' do
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
    visit person_path(person)
    page.should have_content(person.email)
    click_on 'Editar'
    fill_in 'E-mail', with: 'novo@email.com'
    click_on 'Salvar'
    page.should have_content('novo@email.com')
    page.should have_content("Pessoa '#{person.name}' atualizada com sucesso!")
  end

  it 'deleta uma person' do
    person = create(:person)
    visit person_path(person)
    page.should have_content(person.name)
    click_on 'Deletar'
    page.should_not have_content(person.email)
    page.should have_content("Pessoa '#{person.name}' deletada com sucesso!")
  end

  it 'não pode deletar uma person se participa de events' do
    person = create(:person)
    create(:participation, person: person)
    visit person_path(person)
    page.should have_content(person.name)
    find_link('Deletar')[:disabled].should eq "disabled"
  end

  it 'visualiza participações em event' do
    participation = create(:participation)
    visit person_path(participation.person)
    page.should have_content(participation.event.name)
    page.should have_content(participation.participation_type)
  end


end
