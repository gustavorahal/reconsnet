class TmksController < ApplicationController

  before_action :authenticate_user!

  def index
    @query = params[:query]
    @tmks = Tmk.text_search(params[:query]).order('updated_at DESC').page(params[:page]).per(15)
  end


  def new
    @tmk = Tmk.new
  end


  def update
    @tmk = Tmk.find params[:id]

    if @tmk.update(secure_params)
      redirect_to tmks_path
    else
      render 'edit'
    end

  end


  def create
    @tmk = Tmk.new secure_params

    if @tmk.save
      redirect_to tmks_path
    else
      render 'new'
    end
  end


  def destroy
    @tmk = Tmk.find params[:id]
    @tmk.destroy

    redirect_to tmks_path
  end


  def edit
    @tmk = Tmk.find params[:id]
  end

  private

  def secure_params
    params.require(:tmk).permit(:with_who_id, :from_who_id, :when, :contact_type, :event_id, :notes)
  end

end