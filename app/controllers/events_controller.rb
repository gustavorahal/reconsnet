class EventsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def index
    @events = Event.all
    authorize @events
  end

  def show
    @assets = @event.assets.order('assets.name')
    @participations = Participation.includes(:person).where(event: @event).order('people.name')
  end

  def new
    @event = Event.new
    authorize @event
    @activity = nil
    @activity = Activity.find params[:activity_id] if params[:activity_id]
  end

  def edit
  end

  def create
    @event = Event.new(secure_params)
    if @event.activity.blank?
      # neste cenário o activity_id foi passado por url e não veio pelo form
      @event.activity = Activity.find params[:activity_id]
    end
    if @event.name.blank?
      @event.name = @event.activity.name
    end
    authorize @event

    if @event.save
      redirect_to events_path, notice: "Evento '#{@event.name}' adicionado com sucesso!"
    else
      render 'new'
    end
  end

  def update
    if @event.update(secure_params)
      redirect_to @event, notice: "Evento '#{@event.name}' atualizado com sucesso!"
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Evento '#{@event.name}' deletado com sucesso!"
  end


  private

    def set_event
      @event = Event.find params[:id]
      authorize @event
    end

    def secure_params
      params.require(:event).permit(:activity_id, :name, :description, :event_type, :start, :finish, :original_updated_at)
    end

end
