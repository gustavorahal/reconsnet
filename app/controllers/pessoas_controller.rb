class PessoasController < ApplicationController


  def index
    @pessoas = Pessoa.all
  end

  def new
    @pessoa = Pessoa.new
  end

  def create
    @pessoa = Pessoa.new(params.require(:pessoa).permit(:nome, :email, :sexo))

    if @pessoa.save
      redirect_to pessoas_path, notice: "Pessoa '#{@pessoa.nome}' adicionada com sucesso!"
    else
      render 'new'
    end

  end

  def update
    @pessoa = Pessoa.find(params[:id])

    if @pessoa.update(params[:pessoa].permit(:nome, :email))
      redirect_to @pessoa, notice: "Pessoa '#{@pessoa.nome}' atualizada com sucesso!"
    else
      render 'edit'
    end

  end

  def edit
    @pessoa = Pessoa.find(params[:id])
  end

  def show
    @pessoa = Pessoa.find(params[:id])
    @participacoes = Participacao.where(pessoa: @pessoa)
  end

  def destroy
    @pessoa = Pessoa.find(params[:id])

    @participacoes = Participacao.where(pessoa: @pessoa)
    if @participacoes
      flash.now[:alert] = 'Esta pessoa tem participação em eventos, não pode ser deletada'
      render 'show'
    else
      @pessoa.destroy
      redirect_to pessoas_path, notice: "Pessoa '#{@pessoa.nome}' deletada com sucesso!"
    end

  end

end
