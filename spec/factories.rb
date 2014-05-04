FactoryGirl.define do

  factory :user do
    name 'Test User'
    email 'example@example.com'
    role 'Admin'
    password 'changeme'
    password_confirmation 'changeme'
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end

  factory :person do
    sequence(:name) { |n| "João n. #{n}" }
    sequence(:email) { |n| "joao#{n}@email.com" }
    # adicionar telefones já normalizados de acordo com o que o phony espera
    mobile_number '554599440907'
    landline_number '554535755578'
    gender 'Masculino'
  end

  factory :event do
    name 'Imersão Parametodológica'
    event_type 'Curso'
    start Time.now
    finish Time.now
  end

  factory :participation do
    person { |c| c.association(:person) }
    event { |c| c.association(:event) }
    status 'Inscrito'
    participation_type 'Professor'
  end


  ## This will use the User class (Admin would have been guessed)
  #factory :admin, class: User do
  #  first_name "Admin"
  #  last_name  "User"
  #  admin      true
  #end
end