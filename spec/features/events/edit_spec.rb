require 'rails_helper'

describe 'Edita evento' do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end

  it 'altera um evento' do
    event = create :event
    visit event_path(event)
    click_on 'Editar'
    expect(find_field('Nome').value).to eq(event.name)
    desc_txt = 'Uma nova descrição'
    fill_in 'Descrição', with: desc_txt
    click_on 'Salvar'
    expect(page).to have_content "Evento '#{event.name}' atualizado com sucesso!"

  end

end