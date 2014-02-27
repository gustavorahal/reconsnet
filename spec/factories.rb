FactoryGirl.define do

  factory :pessoa do
    nome 'Gustavo Matheus Rahal'
    email 'grahal@me.com'
    sexo 'M'
  end

  factory :evento do
    nome 'Imersão Parametodológica'
    tipo 'Curso'
    inicio Time.now
    fim Time.now
  end

  factory :evento_pessoa do
    pessoa
    evento
    status 'Inscrito'
    tipo_participacao 'Professor'
  end


  ## This will use the User class (Admin would have been guessed)
  #factory :admin, class: User do
  #  first_name "Admin"
  #  last_name  "User"
  #  admin      true
  #end
end