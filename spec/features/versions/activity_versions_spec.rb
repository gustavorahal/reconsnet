require 'rails_helper'

feature 'Versionamento para atividades', versioning: true do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end

  scenario 'atividade é adicionada' do
    activity = create :activity

    visit versions_activity_path(activity)
    expect(page).to have_content("Alterações relacionadas a atividade #{activity.name}")
    expect(page).to have_content("Sistema adicionou atividade")
    expect(page).to have_content("Nome &ltvazio&gt #{activity.name}")

    visit versions_path
    expect(page).to have_content("Sistema adicionou atividade")
    expect(page).to have_content("Nome &ltvazio&gt #{activity.name}")
  end


  scenario 'atividade é deletada' do
    activity = create :activity
    name = activity.name
    activity.destroy

    visit versions_path
    expect(page).to have_content("Sistema excluiu atividade #{name}")
  end

  scenario 'atividade é editada' do
    activity = create :activity
    old_desc = activity.description
    new_desc = 'Descrição da atividade'
    activity.description = new_desc
    activity.save

    visit versions_activity_path(activity)
    expect(page).to have_content("Alterações relacionadas a atividade #{activity.name}")
    expect(page).to have_content("Sistema editou atividade")
    expect(page).to have_content("Descrição #{old_desc} #{new_desc}")

    visit versions_path
    expect(page).to have_content("Sistema editou atividade #{activity.name}")
    expect(page).to have_content("Descrição #{old_desc} #{new_desc}")

  end


end
