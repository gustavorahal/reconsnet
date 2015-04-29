require 'rails_helper'

feature 'Usuário edita uma pessoa' do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end

  scenario 'marcar uma pessoa como necessitando de revisão cadastral' do
    person = create :person
    visit person_path(person)

    click_on 'Ações'
    click_on 'Marcar como "necessita revisão"'

    fill_in 'Razão', with: 'Esta é a razão para revisão'
    click_on 'Marcar'

    expect(page).to have_content 'Esta é a razão para revisão'
    expect(page).to_not have_content 'Marcar como "necessita revisão"'
  end


  scenario 'após de marcado para revisão, revisar' do
    person = create :person, needs_review: true, needs_review_reason: 'Esta é a razão para revisão'
    visit person_path(person)

    expect(page).to have_content 'Esta é a razão para revisão'
    expect(page).to_not have_content 'Marcar como "necessita revisão"'

    click_on 'Tudo certo, revisado!'
    expect(page).to_not have_content 'Esta é a razão para revisão'
    expect(page).to have_content 'Marcar como "necessita revisão"'
  end


  scenario 'deve aparecer uma mensagem na listagem de pessoas, se existirem pessoas para revisão' do
    create :person
    visit people_path
    expect(page).to_not have_content 'Existem pessoas que foram marcadas como necessitando de revisão cadastral.'

    create :person, needs_review: true, needs_review_reason: 'Esta é a razão para revisão'
    visit people_path

    expect(page).to have_content 'Existem pessoas que foram marcadas como necessitando de revisão cadastral.'
  end

end
