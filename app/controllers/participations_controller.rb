
class ParticipationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_participation, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def new
    @event = Event.find(params[:event_id])
    authorize @event
    @participation = Participation.new

    participantes = Participation.where(event: @event)
    # Exclua as pessoas que já fazem parte do evento
    @people = Person.where.not(id: participantes.pluck(:person_id))
  end

  def edit
  end

  def create
    data = secure_params
    @participation = Participation.new(event_id: params[:event_id],
                                       person_id: data[:person],
                                       status: data[:status],
                                       participation_type: data[:participation_type])

    if @participation.save
      redirect_to event_path(@participation.event), notice: 'Participação adicionada com sucesso!'
    else
      render 'new'
    end
  end

  def update
    if @participation.update(secure_params)
      redirect_to event_path(params[:event_id]), notice: 'Participação alterada com sucesso!'
    else
      render 'edit'
    end
  end

  def destroy
    @participation.destroy
    redirect_to event_path(@event), notice: 'Participação deletada com sucesso!'
  end


  def emails
    @event = Event.find(params[:event_id])
    @participations = Participation.includes(:person, :event).where(event: @event).order('event.start DESC')
  end

  private

    def set_participation
      @participation = Participation.find params[:id]
      @event = Event.find params[:event_id]
      authorize @participation
      authorize @event
    end

    def secure_params
      params.require(:participation).permit(:person, :participation_type, :status, :original_updated_at)
    end

end