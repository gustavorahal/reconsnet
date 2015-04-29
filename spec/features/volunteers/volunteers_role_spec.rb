require 'rails_helper'


feature 'Mudança de área de atuação muda papeis no sistema' do

  let(:user) { create :user }
  let(:user_volunteer_manager) { create :user_volunteer_manager_role }


  before :each do
    # É necessário ser do Voluntariado (ou admin) para poder fazer as alterações de áreas
    sign_in(user_volunteer_manager)

    # Criar pessoa e voluntário fazendo os links necessários entre um e outro
    person = create(:person)
    user.person = person
    user.save
    @volunteer = create :volunteer, person: person, area_of_operation: 'none'
  end


  scenario 'Admin muda voluntário para área de Eventos' do

    expect(user.has_role? :event_manager).to be_falsey
    expect(user.has_role? :volunteer).to be_truthy

    visit edit_volunteer_path(@volunteer)
    select 'Eventos', from: 'Área de atuação'
    click_on 'Salvar'

    # confirma que user tem um novo role setado
    User.find user.id
    expect(user.has_role? :event_manager).to be_truthy
    expect(user.has_role? :volunteer).to be_truthy
    expect(user.has_role? :admin).to be_falsey

  end


  scenario 'Admin muda voluntário para área de Voluntariado' do

    expect(user.has_role? :volunteer_manager).to be_falsey
    expect(user.has_role? :volunteer).to be_truthy

    visit edit_volunteer_path(@volunteer)
    select 'Voluntariado', from: 'Área de atuação'
    click_on 'Salvar'

    # confirma que user tem um novo role setado
    User.find user.id
    expect(user.has_role? :volunteer_manager).to be_truthy
    expect(user.has_role? :volunteer).to be_truthy
    expect(user.has_role? :admin).to be_falsey

  end


  scenario 'Admin muda voluntário para área de Coordenação Geral' do

    expect(user.has_role? :admin).to be_falsey
    expect(user.has_role? :volunteer).to be_truthy

    visit edit_volunteer_path(@volunteer)
    select 'Coordenação Geral', from: 'Área de atuação'
    click_on 'Salvar'

    # confirma que user tem um novo role setado
    User.find user.id
    expect(user.has_role? :admin).to be_truthy
    expect(user.has_role? :volunteer).to be_truthy

  end


  scenario 'Admin muda voluntário para área de Banco de Dados' do

    expect(user.has_role? :admin).to be_falsey
    expect(user.has_role? :volunteer).to be_truthy

    visit edit_volunteer_path(@volunteer)
    select 'Banco de Dados', from: 'Área de atuação'
    click_on 'Salvar'

    # confirma que user tem um novo role setado
    User.find user.id
    expect(user.has_role? :admin).to be_truthy
    expect(user.has_role? :volunteer).to be_truthy

  end


  scenario 'Admin muda voluntário da área de Banco de Dados para Comunicação' do

    expect(user.has_role? :admin).to be_falsey
    expect(user.has_role? :volunteer).to be_truthy

    visit edit_volunteer_path(@volunteer)
    select 'Banco de Dados', from: 'Área de atuação'
    click_on 'Salvar'

    expect(user.has_role? :admin).to be_truthy

    visit edit_volunteer_path(@volunteer)
    select 'Comunicação', from: 'Área de atuação'
    click_on 'Salvar'

    expect(user.has_role? :admin).to be_falsey

  end


end