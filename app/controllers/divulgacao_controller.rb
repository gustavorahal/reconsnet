class DivulgacaoController < ApplicationController

  def index
    #@alunos = Person.joins(:participations).uniq(:person)
    @persons = Person.all
  end

end