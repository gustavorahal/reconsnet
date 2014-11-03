class VersionsController < ApplicationController

  def index
    @versions = PaperTrail::Version.all.order(created_at: :desc).page(params[:page]).per(20)
  end

end