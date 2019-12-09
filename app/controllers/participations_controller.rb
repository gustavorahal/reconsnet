
class ParticipationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_participation, only: [:show, :edit, :update, :destroy, :record_attendance]
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
    @people = Person.where.not(id: participations.pluck(:person_id)).order(:name)

    session[:last_page] = request.referrer || event_path(@event)
  end

  def edit
    @person = @participation.person
    session[:last_page] = request.referrer || event_path(@event)
  end

  def create
    @participation = Participation.new secure_params
    authorize @participation

    if @participation.save
      set_roles(@participation)

      if params[:save_and_add_another]
        redirect_to new_event_participation_path(@participation.event, pstatus: Participation.statuses[:enrolled])
      else
        redirect_to event_path(@participation.event)
      end
    else
      render 'new'
    end
  end

  def update
    if @participation.update(secure_params)
      set_roles(@participation)
      redirect_to session[:last_page] || event_path(params[:event_id])
    else
      render 'edit'
    end
  end

  def destroy
    remove_roles(@participation)
    @participation.destroy
    redirect_to request.referrer || event_path(@event)
  end


  def record_attendance
    if params[:attendance].part_present?
      @participation.attendance = params[:attendance].to_i
      if @participation.save
        redirect_to event_path(@participation.event)
      else
        redirect_to event_path(@participation.event), alert: "Erro ao tentar marcar presença para #{@participation.person.name}"
      end
    end
  end


  private

    ##
    # Undo what is done by 'set_roles'

    def remove_roles(participation)
      user = participation.person.user
      return unless user

      user.remove_role :participant, participation.event
      user.remove_role :event_admin, participation.event # to be safe, doesn't hurt removing if it doesn't exist
    end

    def set_roles(participation)
      user = participation.person.user
      return unless user

      # sempre adiciona a permissão de participante
      user.add_role :participant, participation.event

      if participation.teacher?
        user.add_role :event_admin, participation.event
      end

    end

    def set_participation
      @participation = Participation.find params[:id]
      @event = Event.find params[:event_id]
      authorize @participation
      authorize @event
    end

    def secure_params
      params.require(:participation).permit(:person_id, :event_id, :p_type, :status, :attendance)
    end

end