
class ParticipacoesController < ApplicationController


  def new
    @evento = Evento.find(params[:evento_id])
    @participacao = Participacao.new

    participantes = Participacao.where(evento: @evento)
    # Exclua as pessoas que já fazem parte do evento
    @pessoas = Pessoa.where.not(id: participantes.pluck(:pessoa_id))
  end

  def edit
    @evento = Evento.find(params[:evento_id])
    @participacao = Participacao.find(params[:id])
  end


  def update
    @participacao = Participacao.find(params[:id])

    if @participacao.update(params[:participacao].permit(:pessoa_id, :status, :tipo))
      redirect_to evento_path(params[:evento_id]), notice: 'Participação alterada com sucesso!'
    else
      render 'edit'
    end

  end


  def create
    data = params.require(:participacao).permit(:pessoa, :tipo, :status)

    @participacao = Participacao.new(evento_id: params[:evento_id],
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
    @ep = Participacao.find(params[:id])
    @ep.destroy

    redirect_to evento_path(params[:evento_id]), notice: 'Participação deletada com sucesso!'
  end


  def emails
    @evento = Evento.find(params[:evento_id])
    @participacoes = Participacao.includes(:pessoa).where(evento: @evento)
  end

end