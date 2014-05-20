
class ParticipationsController < ApplicationController


  def new
    @event = Event.find(params[:event_id])
    @participation = Participation.new

    participantes = Participation.where(event: @event)
    # Exclua as persons que já fazem parte do event
    @persons = Person.where.not(id: participantes.pluck(:person_id))
  end

  def edit
    @event = Event.find(params[:event_id])
    @participation = Participation.find(params[:id])
  end


  def update
    @participation = Participation.find(params[:id])

    if @participation.update(secure_params)
      redirect_to event_path(params[:event_id]), notice: 'Participação alterada com sucesso!'
    else
      render 'edit'
    end

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


  def destroy
    @ep = Participation.find(params[:id])
    @ep.destroy

    redirect_to event_path(params[:event_id]), notice: 'Participação deletada com sucesso!'
  end


  def emails
    @event = Event.find(params[:event_id])
    @participations = Participation.includes(:person, :event).where(event: @event).order('event.start DESC')
  end

  private

  def secure_params
    params.require(:participation).permit(:person, :participation_type, :status, :original_updated_at)
  end

end