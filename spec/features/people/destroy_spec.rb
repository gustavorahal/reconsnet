
require 'rails_helper'

describe 'Deleta pessoa' do

  before :each do
    sign_in(create :user)
  end

  it 'deleta uma pessoa sem endereço' do
    person = create(:person)
    visit person_path(person)
    expect(page).to have_content(person.name)
    click_on 'Deletar'
    expect(page).to_not have_content(person.email)
    expect(page).to_not have_content(person.name)
  end

  it 'deleta uma pessoa com endereço' do
    person = create :person
    person_id = person.id
    create :address, addressable_id: person_id, addressable_type: 'Person'
    visit person_path(person)
    expect(page).to have_content(person.name)
    click_on 'Deletar'
    expect(page).to_not have_content(person.email)
    expect(page).to_not have_content(person.name)

    expect(Address.where(addressable_id: person_id)).to_not exist
  end

  it 'não pode deletar uma pessoa se participa de algum evento' do
    person = create(:person)
    create(:participation, person: person)
    visit person_path(person)
    expect(page).to have_content(person.name)
    expect(find_link('Deletar')[:disabled]).to eq 'disabled'
  end

end