FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "Test User n. #{n}" }
    email 'example@example.com'
    password 'changeme'
    password_confirmation 'changeme'
    person { |c| c.association(:person) }

    factory :user_admin do
      group 'Admin'
    end

    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end

  factory :person do
    sequence(:name) { |n| "João n. #{n}" }
    sequence(:email) { |n| "joao#{n}@email.com" }
    gender 'Masculino'
  end

  factory :volunteer do
    person { |c| c.association(:person) }
    admission { Time.now }
    area_of_operation 'Voluntariado'
  end

  factory :phone_number do
    # adiciona telefone já normalizado de acordo com o que o phony espera
    number '554599440907'
    phone_type 'Celular'
    provider 'Tim'
    label 'Casa'
  end

  factory :address do
    line1 'Rua Diamantina, 439'
    zip '85868-210'
    city 'Foz do Iguaçu'
    state 'Paraná'
    country 'Brasil'
  end

  factory :event do
    sequence(:name) { |n| "Evento n. #{n}" }
    start Time.now
    finish Time.now
    activity { |c| c.association(:activity) }
  end

  factory :activity do
    sequence(:name) { |n| "Atividade n. #{n}" }
    summary 'Curso sobre isso e aquilo'
    description 'Curso que acontece no Holociclo'
    activity_type 'Curso'
  end

  factory :participation do
    person { |c| c.association(:person) }
    event { |c| c.association(:event) }
    status 'Inscrito'
    participation_type 'Professor'
  end

  factory :tmk do
    with_who { |c| c.association(:person) }
    from_who { |c| c.association(:person) }
    event { |c| c.association(:event) }
    contact_date { Time.now }
    contact_type 'Telefônico'
  end

  ## This will use the User class (Admin would have been guessed)
  #factory :admin, class: User do
  #  first_name "Admin"
  #  last_name  "User"
  #  admin      true
  #end
end