require 'rails_helper'

# Com esta integração, a medida que gerenciamos users no site o estado no site
# deve se refletir no backend (serviço cloud) de envio de mail marketing
# Estes testes rodam no backend real portanto tenho o cuidado de restaurar o estado
# anterior a execução dos testes

feature 'Suporte a integração com backend de mail marketing', slow: true do

  let(:user) { create :user_admin }

  before :each do
    sign_in(user)
  end

  scenario 'após criação de pessoa, se marketing foi selecionado, adiciona-lo ao mail mkt list', sidekiq: :inline do
    person = build :person
    visit new_person_path

    fill_in 'Nome', with: person.name
    fill_in 'E-mail', with: person.email
    check 'Receber divulgação'
    click_on 'Salvar'

    # checa a parte do view em si
    expect(page).to_not have_content 'não esta inscrito na lista de divulgação'
    # checa o status no service
    expect(EmailMktService.subscribed?(person.email)).to be true

    # restaura situação no sistema backend
    EmailMktService.unsubscribe(person.email)
  end


  scenario 'após criação de pessoa, se marketing NÃO foi selecionado, NÃO adiciona-lo ao mail mkt list', sidekiq: :inline do
    person = build :person
    visit new_person_path

    fill_in 'Nome', with: person.name
    fill_in 'E-mail', with: person.email
    uncheck 'Receber divulgação'
    click_on 'Salvar'

    # checa a parte do view em si
    expect(page).to have_content 'Não deseja receber divulgação'
    # checa o status no service
    expect(EmailMktService.subscribed?(person.email)).to be false
  end


  scenario 'após DESmarcar opção pela divulgação, pessoa deve ser removida do backend', sidekiq: :inline do
    person = create :person, marketing: true

    expect(EmailMktService.subscribed?(person.email)).to be true

    visit edit_person_path(person)
    uncheck 'Receber divulgação'
    click_on 'Salvar'

    expect(page).to have_content 'Não deseja receber divulgação'
    expect(EmailMktService.subscribed?(person.email)).to be false
  end



  scenario 'após marcar opção pela divulgação, pessoa deve ser adicionada ao backend', sidekiq: :inline do
    person = create :person, marketing: false

    expect(EmailMktService.subscribed?(person.email)).to be false

    visit edit_person_path(person)
    check 'Receber divulgação'
    click_on 'Salvar'

    expect(page).to_not have_content 'Não deseja receber divulgação'
    expect(EmailMktService.subscribed?(person.email)).to be true

    # restaura situação no sistema backend
    EmailMktService.unsubscribe(person.email)
  end



  scenario 'após deleção de usuário, removê-lo do backend de mail mkt', sidekiq: :inline do
    person = create :person, marketing: true
    expect(EmailMktService.subscribed?(person.email)).to be true

    visit person_path(person)
    click_on 'Deletar'
    expect(EmailMktService.subscribed?(person.email)).to be false
  end

end