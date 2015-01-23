class MarketingController < ApplicationController

  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @people = Person.has_email
    authorize @people
  end

end