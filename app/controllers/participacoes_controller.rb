
class ParticipationsController < ApplicationController


  def new
    @evento = Event.find(params[:evento_id])
    @participacao = Participation.new

    participantes = Participation.where(evento: @evento)
    # Exclua as pessoas que já fazem parte do evento
    @pessoas = Person.where.not(id: participantes.pluck(:pessoa_id))
  end

  def edit
    @evento = Event.find(params[:evento_id])
    @participacao = Participation.find(params[:id])
  end


  def update
    @participacao = Participation.find(params[:id])

    if @participacao.update(params[:participacao].permit(:pessoa_id, :status, :tipo))
      redirect_to evento_path(params[:evento_id]), notice: 'Participação alterada com sucesso!'
    else
      render 'edit'
    end

  end


  def create
    data = params.require(:participacao).permit(:pessoa, :tipo, :status)

    @participacao = Participation.new(evento_id: params[:evento_id],
                                      pessoa_id: data[:pessoa],
                                      status: data[:status],
                                      tipo: data[:tipo])

    if @participacao.save
      redirect_to evento_path(@participacao.evento), notice: 'Participação adicionada com sucesso!'
    else
      render 'new'
    end
  end


  def destroy
    @ep = Participation.find(params[:id])
    @ep.destroy

    redirect_to evento_path(params[:evento_id]), notice: 'Participação deletada com sucesso!'
  end


  def emails
    @evento = Event.find(params[:evento_id])
    @participacoes = Participation.includes(:pessoa).where(evento: @evento)
  end

end