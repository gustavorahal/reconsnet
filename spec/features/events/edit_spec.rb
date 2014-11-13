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

  it 'avisa usuário em caso de conflito' do
    event = create :event
    visit edit_event_path(event)
    sleep 0.5

    in_browser(:two) do
      sign_in(create :user_admin, email: 'novoemail@email.com') # need to sign in here
      visit edit_event_path(event)
      fill_in 'Nome', with: 'Meu evento que mudou de nome'
      click_on 'Salvar'
    end

    fill_in 'Nome', with: 'Meu evento com outro nome'
    click_on 'Salvar'
    expect(page).to have_content 'Este registro mudou enquanto você editava-o'
    expect(page).to have_content 'era Meu evento que mudou de nome'
  end

end