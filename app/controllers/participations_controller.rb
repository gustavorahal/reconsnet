
class ParticipationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_participation, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def new
    @event = Event.find params[:event_id]
    authorize @event
    @participation = Participation.new
    authorize @participation
    @person = nil
    if params[:person_id].present?
      @person = Person.find params[:person_id]
    end
    participations = Participation.where(event: @event)
    # Exclua as pessoas que já fazem parte do evento
    @people = Person.where.not(id: participations.pluck(:person_id)).order('LOWER(name)')

    session[:last_page] = request.referrer || event_path(@event)
  end

  def edit
    @person = @participation.person
    session[:last_page] = request.referrer || event_path(@event)
  end

  def create
    data = secure_params
    @participation = Participation.new(event_id: params[:event_id],
                                       person_id: data[:person] || params[:person_id],
                                       status: data[:status],
                                       participation_type: data[:participation_type])
    authorize @participation
    if @participation.save
      redirect_to session[:last_page] || event_path(@participation.event)
    else
      render 'new'
    end
  end

  def update
    if @participation.update(secure_params)
      redirect_to session[:last_page] || event_path(params[:event_id])
    else
      render 'edit'
    end
  end

  def destroy
    @participation.destroy
    redirect_to session[:last_page] || event_path(@event)
  end


  def emails
    @event = Event.find(params[:event_id])
    authorize @event

    @enrolled, @pre_enrolled, @interested  = Participation.participations(@event)
  end

  private

    def set_participation
      @participation = Participation.find params[:id]
      @event = Event.find params[:event_id]
      authorize @participation
      authorize @event
    end

    def secure_params
      params.require(:participation).permit(:person, :person_id, :participation_type, :status, :original_updated_at)
    end

end