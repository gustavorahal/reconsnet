require 'rails_helper'

feature 'Usuário busca contatos TMK' do

  before :each do
    sign_in(create :user)
  end

  scenario 'busca um contato tmk que existe' do
    tmk1 = create :tmk
    tmk2 = create :tmk
    visit tmks_path
    expect(page).to have_content tmk1.with_who.name
    expect(page).to have_content tmk2.with_who.name

    fill_in 'query', with: tmk1.with_who.name
    click_on 'btn-search'
    expect(page).to have_content tmk1.with_who.name
    expect(page).to_not have_content tmk2.with_who.name
  end

  scenario 'busca um contato tmk que não existe' do
    tmk1 = create :tmk
    tmk2 = create :tmk
    visit tmks_path
    expect(page).to have_content tmk1.with_who.name
    expect(page).to have_content tmk2.with_who.name

    fill_in 'query', with: 'não existe'
    click_on 'btn-search'
    expect(page).to_not have_content tmk1.with_who.name
    expect(page).to_not have_content tmk2.with_who.name
  end

end