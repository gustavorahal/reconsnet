FactoryGirl.define do

  factory :role do
    
  end

  factory :user do
    sequence(:name) { |n| "Test User n. #{n}" }
    sequence(:email) { |n| "test_user#{n}@email.com" }
    password 'changeme'
    password_confirmation 'changeme'

    factory :user_admin do
      after(:build) do |user, evaluator|
        user.add_role :admin
      end
    end

    factory :user_event_admin_role do
      after(:build) do |user, evaluator|
        user.add_role :event_admin
        user.add_role :volunteer
      end
    end

    factory :user_volunteer_admin_role do
      after(:build) do |user, evaluator|
        user.add_role :volunteer_admin
        user.add_role :volunteer
      end
    end

    factory :user_person_admin_role do
      after(:build) do |user, evaluator|
        user.add_role :person_admin
        user.add_role :volunteer
      end
    end

    factory :user_volunteer_role do
      after(:build) do |user, evaluator|
        user.add_role :volunteer
      end
    end

    factory :user_instructor_role do
      after(:build) do |user, evaluator|
        user.add_role :instructor
        user.add_role :volunteer
      end
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
    finish (Time.now + 1.day)
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
    status Participation.statuses[:enrolled]
    p_type Participation.p_types[:teacher]
  end

  factory :tmk do
    with_who { |c| c.association(:person) }
    from_who { |c| c.association(:person) }
    event { |c| c.association(:event) }
    contact_date { Time.now }
    contact_type 'Telefônico'
  end

  factory :asset do

    file_file_name 'lista_de_presenca.pdf'
    file_file_size 1234

    factory :asset_event_participant_material do
      after(:build) do |asset, evaluator|
        event = create :event
        asset.assetable_id = event.id
        asset.assetable_type = 'Event'
        asset.save
      end
      asset_type :participant_material
    end

    factory :asset_event_instructor_material do
      after(:build) do |asset, evaluator|
        event = create :event
        asset.assetable_id = event.id
        asset.assetable_type = 'Event'
        asset.save
      end
      asset_type :instructor_material
    end

  end

  ## This will use the User class (Admin would have been guessed)
  #factory :admin, class: User do
  #  first_name "Admin"
  #  last_name  "User"
  #  admin      true
  #end
end