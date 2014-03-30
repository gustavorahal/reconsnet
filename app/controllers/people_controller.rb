class PeopleController < ApplicationController

  def index
    @persons = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(params.require(:person).permit(:name, :email, :gender))

    if @person.save
      redirect_to people_path, notice: "Pessoa '#{@person.name}' adicionada com sucesso!"
    else
      render 'new'
    end

  end

  def update
    @person = Person.find(params[:id])

    if @person.update(params[:person].permit(:name, :email))
      redirect_to @person, notice: "Pessoa '#{@person.name}' atualizada com sucesso!"
    else
      render 'edit'
    end

  end

  def edit
    @person = Person.find(params[:id])
  end

  def show
    @person = Person.find(params[:id])
    @participations = Participation.where(person: @person)
  end

  def destroy
    @person = Person.find(params[:id])

    @participations = Participation.where(person: @person)
    if @participations.any?
      flash.now[:alert] = 'Esta person tem participação em events, não pode ser deletada'
      render 'show'
    else
      @person.destroy
      redirect_to people_path, notice: "Pessoa '#{@person.name}' deletada com sucesso!"
    end

  end

end
