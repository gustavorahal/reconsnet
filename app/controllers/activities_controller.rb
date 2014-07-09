class ActivitiesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def index
    @activities = Activity.all
    authorize @activities
  end

  def show
    @events = @activity.all_events.order('events.start')
  end

  def new
    @activity = Activity.new
    authorize @activity
  end

  def edit
  end

  def create
    @activity = Activity.new(secure_params)
    authorize @activity

    if @activity.save
      redirect_to activities_path, notice: "Atividade '#{@activity.name}' adicionada com sucesso!"
    else
      render 'new'
    end
  end

  def update
    if @activity.update(secure_params)
      redirect_to @activity, notice: "Atividade '#{@activity.name}' atualizada com sucesso!"
    else
      render 'edit'
    end
  end

  def destroy
    @activity.destroy
    redirect_to activities_path, notice: "Atividade '#{@activity.name}' deletada com sucesso!"
  end


  private

    def set_activity
      @activity = Activity.find params[:id]
      authorize @activity
    end

    def secure_params
      params.require(:activity).permit(:name, :summary, :parent_id,
                                       :description, :activity_type, :internal_only)
    end

end