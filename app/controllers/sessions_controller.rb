class SessionsController < ApplicationController

  #def new
  #
  #  # Reset the session everytime we issue a new login page. This will clear
  #  # the rails session variable.
  #  reset_session
  #
  #end
  #
  #def create
  #  user = Usuario.from_omniauth(env['omniauth.auth'])
  #  session[:user_id] = user.id
  #  redirect_to root_url, notice: 'Signed in!'
  #end
  #
  #def destroy
  #  session[:user_id] = nil
  #  redirect_to root_url, notice: 'Signed out!'
  #end
  #
  #def failure
  #  flash[:alert] = "foobar"
  #  redirect_to login_url, alert: 'Authentication failed, please try again.'
  #end

end
