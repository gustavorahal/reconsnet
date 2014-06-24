class VolunteersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_volunteer, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def index
    @volunteers = Volunteer.all
    authorize @volunteers
  end

  def show
  end

  def new
    @volunteer = Volunteer.new
    authorize @volunteer
  end

  def edit
  end

  def create
    @volunteer = Volunteer.new(volunteer_params)
    authorize @volunteer

    if @volunteer.save
      redirect_to @volunteer, notice: 'Volunteer was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @volunteer.update(volunteer_params)
      redirect_to @volunteer, notice: 'Volunteer was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @volunteer.destroy
    redirect_to volunteers_path
  end


  private

    def set_volunteer
      @volunteer = Volunteer.find(params[:id])
      authorize @volunteer
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def volunteer_params
      params.require(:volunteer).permit(:person_id, :admission, :area_of_operation)
    end
end
