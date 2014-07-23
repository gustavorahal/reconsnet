
require 'rails_helper'

feature 'Usuário deleta uma atividade' do

  before :each do
    sign_in(create :user)
  end

  scenario 'página da atividade esta aberta' do
    activity = create :activity
    visit activity_path(activity)

    click_on 'Deletar'

    expect(page).to have_content "Atividade '#{activity.name}' deletada com sucesso!"
  end
end