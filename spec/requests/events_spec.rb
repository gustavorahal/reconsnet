require 'spec_helper'

describe 'Events' do

  before :each do
    sign_in(create :user)
  end

  it 'adiciona novo event' do
    event = build(:event)
    visit events_path
    click_on 'Adicionar'
    fill_in 'Nome', with: event.name
    select event.event_type, from: 'Tipo de evento'
    fill_in 'Início', with: event.start
    fill_in 'Fim', with: event.finish
    click_on 'Salvar'

    current_path.should eq(events_path)

    page.should have_content("Evento '#{event.name}' adicionado com sucesso!")
  end


  it 'deleta um event' do
    event = create(:event)
    visit event_path(event)
    page.should have_content(event.name)
    click_on 'Deletar'
    page.should have_content("Evento '#{event.name}' deletado com sucesso!")
  end


  it 'deleta um event deve deletar todas as participations' do
    event = create :event
    visit event_path(event)
    page.should have_content(event.name)

    create :participation, person: create(:person), event: event
    create :participation, person: create(:person), event: event
    click_on 'Deletar'
    page.should have_content("Evento '#{event.name}' deletado com sucesso!")

    Participation.where(event: event).should be_empty
  end


  it 'altera um evento' do
    event = create(:event)
    visit event_path(event)
    click_on 'Editar'
    find_field('Nome').value.should eq(event.name)
    desc_txt = 'Uma nova descrição'
    fill_in 'Descrição', with: desc_txt
    click_on 'Salvar'
    page.should have_content("Evento '#{event.name}' atualizado com sucesso!")

  end

  it 'avisa usuário em caso de conflito' do
    event = create(:event)
    visit edit_event_path(event)
    sleep 0.5
    in_browser(:two) do
      sign_in(create :user, email: 'novoemail@email.com') # need to sign in here
      visit edit_event_path(event)
      fill_in 'Nome', with: 'Meu evento que mudou de nome'
      click_on 'Salvar'
    end

    fill_in 'Nome', with: 'Meu evento com outro nome'
    click_on 'Salvar'
    page.should have_content('Este registro mudou enquanto você estava editando-o')
    page.should have_content('era Meu evento que mudou de nome')
  end


end
