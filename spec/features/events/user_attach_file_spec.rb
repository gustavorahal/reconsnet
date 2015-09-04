require 'rails_helper'


feature 'Anexo de arquivo a evento' do

  before :each do
    sign_in(create :user_event_admin_role)
  end

  def add_asset(event, asset_type)
    visit event_path(event)
    click_on 'Novo anexo'
    select I18n.t("asset_types.#{asset_type}")
    page.attach_file 'Arquivo', 'spec/data/capybara.pdf'
    click_on 'Salvar'
  end

  scenario 'admin de evento pode ver material do participante e do professor' do
    event = create :event
    add_asset(event, :participant_material)
    add_asset(event, :teacher_material)

    expect(page).to have_content 'capybara.pdf (Material do Participante)'
    expect(page).to have_content 'capybara.pdf (Material do Professor)'
  end

  scenario 'participante pode ver material do participante mas não do professor' do
    event = create :event
    add_asset(event, :participant_material)
    add_asset(event, :teacher_material)

    logout

    user = create :user
    user.add_role :participant, event

    sign_in(user)
    visit event_path(event)
    expect(page).to have_content 'capybara.pdf (Material do Participante)'
    expect(page).to_not have_content 'capybara.pdf (Material do Professor)'
  end

  scenario 'visitante não pode ver material do participante nem do professor' do
    event = create :event
    add_asset(event, :participant_material)
    add_asset(event, :teacher_material)

    logout

    user = create :user

    sign_in(user)
    visit event_path(event)
    expect(page).to_not have_content 'capybara.pdf (Material do Participante)'
    expect(page).to_not have_content 'capybara.pdf (Material do Professor)'
  end

  scenario 'professor GLOBAL pode ver material do participante e do professor' do
    event = create :event
    add_asset(event, :participant_material)
    add_asset(event, :teacher_material)

    logout

    user = create :user
    user.add_role :teacher

    sign_in(user)
    visit event_path(event)
    expect(page).to have_content 'capybara.pdf (Material do Participante)'
    expect(page).to have_content 'capybara.pdf (Material do Professor)'
  end

end
