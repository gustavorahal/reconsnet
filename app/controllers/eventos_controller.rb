class EventosController < ApplicationController

  def index
    @eventos = Evento.all
  end


  def new
    @evento = Evento.new
  end


  def create
    @evento = Evento.new(params.require(:evento).permit(:nome, :descricao, :tipo, :inicio, :fim))

    if @evento.save
      redirect_to eventos_path
    else
      render 'new'
    end
  end


  def update
    @evento = Evento.find(params[:id])

    if @evento.update(params[:evento].permit(:nome, :descricao, :tipo, :inicio, :fim))
      redirect_to @evento
    else
      render 'edit'
    end

  end


  def edit
    @evento = Evento.find(params[:id])
  end


  def show
    @evento = Evento.find(params[:id])
    @evento_pessoas = EventoPessoa.where(evento: @evento)
  end


  def destroy
    @evento = Evento.find(params[:id])
    @evento.destroy

    redirect_to eventos_path
  end



  #
  # Operações para Participação
  #

  def new_participacao
    @evento = Evento.find(params[:evento_id])
    @evento_pessoa = EventoPessoa.new

    participantes = EventoPessoa.where(evento: @evento)
    # Exclua as pessoas que já fazem parte do evento
    @pessoas = Pessoa.where.not(id: participantes.pluck(:pessoa_id))
  end


  def create_participacao
    data = params.require(:evento_pessoa).permit(:pessoa_id, :tipo_participacao)

    @evento_pessoa = EventoPessoa.new(evento_id: params[:evento_id],
                                      pessoa_id: data[:pessoa_id],
                                      tipo_participacao: data[:tipo_participacao])

    if @evento_pessoa.save
      redirect_to evento_path(@evento_pessoa.evento)
    else
      render 'new_participacao'
    end
  end


  def destroy_participacao
    @ep = EventoPessoa.find(params[:id])
    @ep.destroy

    redirect_to evento_path(params[:evento_id])
  end

end
