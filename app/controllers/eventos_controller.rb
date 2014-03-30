class EventsController < ApplicationController

  def index
    @eventos = Event.all
    authorize @eventos
  end


  def new
    @evento = Event.new
  end


  def create
    @evento = Event.new(params.require(:evento).permit(:name, :descricao, :tipo, :inicio, :fim))

    if @evento.save
      redirect_to eventos_path, notice: "Event '#{@evento.name}' adicionado com sucesso!"
    else
      render 'new'
    end
  end


  def update
    @evento = Event.find(params[:id])

    if @evento.update(params[:evento].permit(:name, :descricao, :tipo, :inicio, :fim))
      redirect_to @evento, notice: "Event '#{@evento.name}' atualizado com sucesso!"
    else
      render 'edit'
    end

  end


  def edit
    @evento = Event.find(params[:id])
    authorize @evento
  end


  def show
    @evento = Event.find(params[:id])
    authorize @evento
    @participacoes = Participation.where(evento: @evento)
  end


  def destroy
    @evento = Event.find(params[:id])
    @evento.destroy

    redirect_to eventos_path, notice: "Evento '#{@evento.name}' deletado com sucesso!"
  end


end
