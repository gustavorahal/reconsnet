class TmksController < ApplicationController

  before_action :authenticate_user!
  before_action :set_tmk, only: [:edit, :update, :destroy]
  after_action :verify_authorized

  def index
    @query = params[:query]
    @event = nil
    if params[:event_id].present?
      @event = Event.find params[:event_id]
      @tmks = Tmk.text_search(params[:query]).order('contact_date DESC')
      @tmks = @tmks.where(event: @event).page(params[:page]).per(15)
    else
      @tmks = Tmk.text_search(params[:query]).order('contact_date DESC').page(params[:page]).per(15)
    end
    authorize @tmks
  end

  def new
    @tmk = Tmk.new
    authorize @tmk

    @with_who = params[:with_who_id].present? ? Person.find(params[:with_who_id]) : nil
    @event = params[:event_id].present? ? Event.find(params[:event_id]) : nil

    session[:last_page] = request.referrer || tmks_path
  end

  def edit
    session[:last_page] = request.referrer || tmks_path
  end

  def create
    @tmk = Tmk.new secure_params
    authorize @tmk

    @with_who = params[:with_who_id].present? ? Person.find(params[:with_who_id]) : nil
    @event = params[:event_id].present? ? Event.find(params[:event_id]) : nil

    if @tmk.save
      redirect_to session[:last_page] || tmks_path
    else
      render 'new'
    end
  end

  def update
    if @tmk.update(secure_params)
      redirect_to session[:last_page] || tmks_path
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
      params.require(:tmk).permit(:with_who_id, :from_who_id, :contact_date, :contact_type, :event_id, :notes)
    end

end