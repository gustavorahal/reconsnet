
class EventoPessoasController < ApplicationController


  def new
    @evento = Evento.find(params[:evento_id])
    @evento_pessoa = EventoPessoa.new

    participantes = EventoPessoa.where(evento: @evento)
    # Exclua as pessoas que já fazem parte do evento
    @pessoas = Pessoa.where.not(id: participantes.pluck(:pessoa_id))
  end

  def edit
    @evento_pessoa = EventoPessoa.find(params[:id])
  end


  def update
    @evento_pessoa = EventoPessoa.find(params[:id])

    if @evento_pessoa.update(params[:evento_pessoa].permit(:pessoa_id, :status, :tipo_participacao))
      redirect_to evento_path(params[:evento_id])
    else
      render 'edit'
    end

  end


  def create
    data = params.require(:evento_pessoa).permit(:pessoa, :tipo_participacao, :status)

    @evento_pessoa = EventoPessoa.new(evento_id: params[:evento_id],
                                      pessoa_id: data[:pessoa],
                                      status: data[:status],
                                      tipo_participacao: data[:tipo_participacao])

    if @evento_pessoa.save
      redirect_to evento_path(@evento_pessoa.evento)
    else
      render 'new'
    end
  end


  def destroy
    @ep = EventoPessoa.find(params[:id])
    @ep.destroy

    redirect_to evento_path(params[:evento_id])
  end

end