require 'rails_helper'

describe 'Marketing' do

  before :each do
    sign_in(create :user_admin)
  end

  it 'somente lista emails de pessoas que permitiram divulgação' do
    person1 = create :person, marketing: true
    person2 = create :person, marketing: true
    person3 = create :person, marketing: false

    visit marketing_path

    expect(page).to have_content person1.email
    expect(page).to have_content person2.email
    expect(page).to_not have_content person3.email
  end


end