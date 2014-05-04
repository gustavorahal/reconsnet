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
    page.should have_content('Telefone Fixo: 045 3575 5578')
    page.should have_content('Telefone Celular: 045 9944 0907')
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
    page.should have_content('Telefone Fixo: 045 3575 5566')
    page.should have_content('Telefone Celular: 045 9944 0988')
  end


  it 'deleta uma person' do
    person = create(:person)
    visit person_path(person)
    page.should have_content(person.name)
    click_on 'Deletar'
    page.should_not have_content(person.email)
    page.should have_content("Pessoa '#{person.name}' deletada com sucesso!")
  end

  it 'não pode deletar uma person se participa de eventos' do
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
