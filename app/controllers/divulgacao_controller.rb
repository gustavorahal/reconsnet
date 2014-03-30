class DivulgacaoController < ApplicationController

  def index
    #@alunos = Person.joins(:participacoes).uniq(:pessoa)
    @pessoas = Person.all
  end

end