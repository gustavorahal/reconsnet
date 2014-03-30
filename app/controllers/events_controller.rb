class EventsController < ApplicationController

  def index
    @events = Event.all
    authorize @events
  end


  def new
    @event = Event.new
  end


  def create
    @event = Event.new(params.require(:event).permit(:name, :description, :event_type, :start, :finish))

    if @event.save
      redirect_to events_path, notice: "Evento '#{@event.name}' adicionado com sucesso!"
    else
      render 'new'
    end
  end


  def update
    @event = Event.find(params[:id])

    if @event.update(params[:event].permit(:name, :description, :event_type, :start, :finish))
      redirect_to @event, notice: "Evento '#{@event.name}' atualizado com sucesso!"
    else
      render 'edit'
    end

  end


  def edit
    @event = Event.find(params[:id])
    authorize @event
  end


  def show
    @event = Event.find(params[:id])
    authorize @event
    @participations = Participation.where(event: @event)
  end


  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    redirect_to events_path, notice: "Evento '#{@event.name}' deletado com sucesso!"
  end


end
