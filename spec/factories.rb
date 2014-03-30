FactoryGirl.define do

  #factory :identity do
  #  sequence(:name) { |n| "João n. #{n}" }
  #  sequence(:email) { |n| "joao#{n}@email.com" }
  #  password '123456'
  #end

  #factory :usuario do
  #  papel 'Admin'
  #  sequence(:name) { |n| "João n. #{n}" }
  #  sequence(:email) { |n| "joao#{n}@email.com" }
  #  sequence(:identity_uid) { |n| n.to_s }
  #end


  factory :person do
    sequence(:name) { |n| "João n. #{n}" }
    sequence(:email) { |n| "joao#{n}@email.com" }
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