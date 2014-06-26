class TmksController < ApplicationController

  before_action :authenticate_user!
  before_action :set_tmk, only: [:edit, :update, :destroy]
  after_action :verify_authorized

  def index
    @query = params[:query]
    @tmks = Tmk.text_search(params[:query]).order('updated_at DESC').page(params[:page]).per(15)
    authorize @tmks
  end

  def new
    @tmk = Tmk.new
    authorize @tmk
  end

  def edit
  end

  def create
    @tmk = Tmk.new secure_params
    authorize @tmk

    if @tmk.save
      redirect_to tmks_path
    else
      render 'new'
    end
  end

  def update
    if @tmk.update(secure_params)
      redirect_to tmks_path
    else
      render 'edit'
    end
  end

  def destroy
    @tmk.destroy
    redirect_to tmks_path
  end



  private

    def set_tmk
      @tmk = Tmk.find params[:id]
      authorize @tmk
    end

    def secure_params
      params.require(:tmk).permit(:with_who_id, :from_who_id, :when, :contact_type, :event_id, :notes)
    end

end