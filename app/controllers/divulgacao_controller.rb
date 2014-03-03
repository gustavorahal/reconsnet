class DivulgacaoController < ApplicationController

  def index
    #@alunos = Pessoa.joins(:participacoes).uniq(:pessoa)
    @pessoas = Pessoa.all
  end

end