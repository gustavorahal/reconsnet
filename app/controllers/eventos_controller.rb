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
      redirect_to eventos_path, notice: "Evento '#{@evento.nome}' adicionado com sucesso!"
    else
      render 'new'
    end
  end


  def update
    @evento = Evento.find(params[:id])

    if @evento.update(params[:evento].permit(:nome, :descricao, :tipo, :inicio, :fim))
      redirect_to @evento, notice: "Evento '#{@evento.nome}' atualizado com sucesso!"
    else
      render 'edit'
    end

  end


  def edit
    @evento = Evento.find(params[:id])
  end


  def show
    @evento = Evento.find(params[:id])
    @participacoes = Participacao.where(evento: @evento)
  end


  def destroy
    @evento = Evento.find(params[:id])
    @evento.destroy

    redirect_to eventos_path, notice: "Evento '#{@evento.nome}' deletado com sucesso!"
  end


end
