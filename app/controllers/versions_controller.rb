class VersionsController < ApplicationController

  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @versions = PaperTrail::Version.all.order(created_at: :desc).page(params[:page]).per(10)
    authorize @versions
  end

end