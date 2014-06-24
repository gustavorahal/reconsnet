class DivulgacaoController < ApplicationController

  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @people = Person.all
    authorize @people
  end

end