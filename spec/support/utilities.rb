def sign_in(user)
  visit new_user_session_path
  fill_in 'Email',    with: user.email
  fill_in 'Senha', with: user.password
  click_button 'Entrar'
end
