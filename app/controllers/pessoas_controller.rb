class PessoasController < ApplicationController


  def index
    @pessoas = Pessoa.all
  end

  def new
    @pessoa = Pessoa.new
  end

  def create
    @pessoa = Pessoa.new(params.require(:pessoa).permit(:nome, :email))

    if @pessoa.save
      redirect_to pessoas_path
    else
      render 'new'
    end

  end

  def update
    @pessoa = Pessoa.find(params[:id])

    if @pessoa.update(params[:pessoa].permit(:nome, :email))
      redirect_to @pessoa
    else
      render 'edit'
    end

  end

  def edit
    @pessoa = Pessoa.find(params[:id])
  end

  def show
    @pessoa = Pessoa.find(params[:id])
    @pessoa_eventos = EventoPessoa.where(pessoa: @pessoa)
  end

  def destroy
    @pessoa = Pessoa.find(params[:id])
    @pessoa.destroy

    redirect_to pessoas_path
  end

end
