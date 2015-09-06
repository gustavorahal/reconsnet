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

  scenario 'admin de evento pode ver material do participante e do docente' do
    event = create :event
    add_asset(event, :participant_material)
    add_asset(event, :instructor_material)

    expect(page).to have_content 'capybara.pdf (Material do Participante)'
    expect(page).to have_content 'capybara.pdf (Material do Docente)'
  end

  scenario 'participante pode ver material do participante mas não do docente' do
    event = create :event
    add_asset(event, :participant_material)
    add_asset(event, :instructor_material)

    logout

    user = create :user
    user.add_role :participant, event

    sign_in(user)
    visit event_path(event)
    expect(page).to have_content 'capybara.pdf (Material do Participante)'
    expect(page).to_not have_content 'capybara.pdf (Material do Docente)'
  end

  scenario 'visitante não pode ver material do participante nem do docente' do
    event = create :event
    add_asset(event, :participant_material)
    add_asset(event, :instructor_material)

    logout

    user = create :user

    sign_in(user)
    visit event_path(event)
    expect(page).to_not have_content 'capybara.pdf (Material do Participante)'
    expect(page).to_not have_content 'capybara.pdf (Material do Docente)'
  end

  scenario 'docente GLOBAL pode ver material do participante e do docente' do
    event = create :event
    add_asset(event, :participant_material)
    add_asset(event, :instructor_material)

    logout

    user = create :user
    user.add_role :instructor

    sign_in(user)
    visit event_path(event)
    expect(page).to have_content 'capybara.pdf (Material do Participante)'
    expect(page).to have_content 'capybara.pdf (Material do Docente)'
  end

end
