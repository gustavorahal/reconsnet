class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception




private

  # Usado pelo pundit para obter o usuário atual
  def current_user
    @current_user ||= Usuario.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user


end
