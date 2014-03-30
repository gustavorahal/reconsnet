class PeopleController < ApplicationController

  def index
    @pessoas = Person.all
  end

  def new
    @pessoa = Person.new
  end

  def create
    @pessoa = Person.new(params.require(:pessoa).permit(:name, :email, :sexo))

    if @pessoa.save
      redirect_to pessoas_path, notice: "Pessoa '#{@pessoa.name}' adicionada com sucesso!"
    else
      render 'new'
    end

  end

  def update
    @pessoa = Person.find(params[:id])

    if @pessoa.update(params[:pessoa].permit(:name, :email))
      redirect_to @pessoa, notice: "Pessoa '#{@pessoa.name}' atualizada com sucesso!"
    else
      render 'edit'
    end

  end

  def edit
    @pessoa = Person.find(params[:id])
  end

  def show
    @pessoa = Person.find(params[:id])
    @participacoes = Participation.where(pessoa: @pessoa)
  end

  def destroy
    @pessoa = Person.find(params[:id])

    @participacoes = Participation.where(pessoa: @pessoa)
    if @participacoes.any?
      flash.now[:alert] = 'Esta pessoa tem participação em eventos, não pode ser deletada'
      render 'show'
    else
      @pessoa.destroy
      redirect_to pessoas_path, notice: "Pessoa '#{@pessoa.name}' deletada com sucesso!"
    end

  end

end
