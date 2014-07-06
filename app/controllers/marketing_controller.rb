class MarketingController < ApplicationController

  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @people = Person.where(marketing: true)
    authorize @people
  end

end