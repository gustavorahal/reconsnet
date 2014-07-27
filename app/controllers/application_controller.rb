class ApplicationController < ActionController::Base

  before_action :set_menu_values, unless: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  def index
    user = current_user
    if user and user.volunteer?
      @next_event = Event.next_event
      @events = Event.all.order(start: :desc)
    else
      @next_event = Event.next_event(exclude_internal = true)
      @events = Event.all_exclude_internal
    end
  end

  private

    def set_menu_values
      @activities = policy_scope(Activity)
      authorize @activities
      # Apenas listar as atividades pai (de nível mais alto)
      @activities = @activities.where(parent: nil).order(:name)
    end

    def user_not_authorized
      flash[:alert] = 'Você não tem autorização para realizar esta ação.'
      redirect_to(request.referrer || root_path)
    end

end
