def sign_in(user)
  visit new_user_session_path
  fill_in 'Email',    with: user.email
  fill_in 'Senha', with: user.password
  click_button 'Entrar'
end


def sign_in_as_volunteer
  volunteer = create :volunteer
  person = volunteer.person
  user = create(:user, person: person, email: person.email)
  visit new_user_session_path
  fill_in 'Email',    with: user.email
  fill_in 'Senha', with: user.password
  click_button 'Entrar'
end


def in_browser(name)
  old_session = Capybara.session_name

  Capybara.session_name = name
  yield

  Capybara.session_name = old_session
end


##
# Seleciona uma data em um form que usa o date_select padrão do rails
# Exemplo: select_date('2015-03-15', from: 'Data')

def select_date(date_obj, options = {})
  field = options[:from]
  base_id = find(:xpath, ".//label[contains(.,'#{field}')]")[:for]
  date = date_obj.to_date
  select date.year,  :from => "#{base_id}_1i"
  select date.month, :from => "#{base_id}_2i"
  select date.day,   :from => "#{base_id}_3i"
end


##
# Seleciona uma data e hora em um form que usa o datetime_select padrão do rails
# Exemplo: select_date('2015-03-15 14:34', from: 'Data e hora')

def select_datetime(datetime_obj, options = {})
  field = options[:from]
  base_id = find(:xpath, ".//label[contains(.,'#{field}')]")[:for]
  datetime = datetime_obj.to_datetime
  select datetime.year,  :from => "#{base_id}_1i"
  select I18n.l(datetime, format: "%B"), :from => "#{base_id}_2i"
  select datetime.day,   :from => "#{base_id}_3i"
  select 12,   :from => "#{base_id}_4i"
  select 30,   :from => "#{base_id}_5i"
end