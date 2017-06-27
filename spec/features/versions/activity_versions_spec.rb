require 'rails_helper'

feature 'Versionamento para atividades', versioning: true do

  let(:user) { create :user_admin }

  # Create an activity as the logged in user so we can test if versions is tracking
  # the author of the changes
  let(:new_activity) {
    visit activities_path
    click_on 'Nova atividade'
    fill_in 'Nome', with: 'Nova atividade'
    fill_in 'Sumário', with: 'Esta nova atividade é bastante interessante'
    click_on 'Salvar'
    Activity.last!
  }

  before :each do
    sign_in(user)
  end

  scenario 'atividade é adicionada pelo sistema' do
    activity = create :activity

    visit versions_activity_path(activity)
    expect(page).to have_content("Alterações relacionadas a atividade #{activity.name}")
    expect(page).to have_content("Sistema adicionou atividade")
    expect(page).to have_content("Nome &ltvazio&gt #{activity.name}")

    visit versions_path
    expect(page).to have_content("Sistema adicionou atividade")
    expect(page).to have_content("Nome &ltvazio&gt #{activity.name}")
  end


  scenario 'atividade é adicionada por usuário logado' do
    activity = new_activity

    visit versions_activity_path(activity)
    expect(page).to have_content("Alterações relacionadas a atividade #{activity.name}")
    expect(page).to have_content("#{user.name} adicionou atividade")
    expect(page).to have_content("Nome &ltvazio&gt #{activity.name}")

    visit versions_path
    expect(page).to have_content("#{user.name} adicionou atividade")
    expect(page).to have_content("Nome &ltvazio&gt #{activity.name}")
  end


  scenario 'atividade é deletada por usuário logado' do
    activity = create :activity
    name = activity.name

    visit activity_path(activity)
    click_on 'Deletar'

    visit versions_path
    expect(page).to have_content("#{user.name} excluiu atividade #{name}")
  end


  scenario 'atividade é editada por usuário logado' do
    activity = new_activity
    old_summary = activity.summary
    new_summary = 'Descrição da atividade'
    visit edit_activity_path(activity)
    fill_in 'Sumário', with: new_summary
    click_on 'Salvar'

    visit versions_activity_path(activity)
    expect(page).to have_content("Alterações relacionadas a atividade #{activity.name}")
    expect(page).to have_content("#{user.name} editou atividade")
    expect(page).to have_content("Sumário #{old_summary} #{new_summary}")

    visit versions_path
    expect(page).to have_content("#{user.name} editou atividade #{activity.name}")
    expect(page).to have_content("Sumário #{old_summary} #{new_summary}")
  end


end
