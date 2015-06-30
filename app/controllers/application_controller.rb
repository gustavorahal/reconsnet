class ApplicationController < ActionController::Base

  before_action :set_menu_values, unless: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  def index
    user = current_user
    if user and user.is_volunteer?
      @next_event = Event.next_event
      @events = Event.sorted.where('start > ?', Time.now)
      @tmks = Tmk.all.order('contact_date DESC').limit(5)
      @people = Person.all.order('created_at DESC').limit(5)
    else
      @next_event = Event.next_event(exclude_internal = true)
      @events = Event.sorted.all_exclude_internal.where('start > ?', Time.now)
      @tmks = nil
      @people = nil
    end
  end

  def about

  end


  private

    def set_menu_values
      @activities_menu_items = policy_scope(Activity)
      authorize @activities_menu_items
      # Apenas listar as atividades pai (de nível mais alto)
      @activities_menu_items = @activities_menu_items.where(parent: nil).order(:name)
    end

    def user_not_authorized
      flash[:alert] = 'Você não tem autorização para realizar esta ação.'
      redirect_to(request.referrer || root_path)
    end

end
