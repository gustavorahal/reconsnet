
require 'rails_helper'

feature 'Usuário deleta uma atividade' do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end

  scenario 'página da atividade esta aberta' do
    activity = create :activity
    visit activity_path(activity)

    click_on 'Deletar'

    expect(page).to have_content "Atividade '#{activity.name}' deletada com sucesso!"
  end
end