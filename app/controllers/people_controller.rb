class PeopleController < ApplicationController

  before_action :authenticate_user!
  before_action :set_person, only: [:show, :versions, :edit, :update, :destroy]
  before_action :set_tmks, only: [:show, :destroy]
  after_action :verify_authorized

  def index
    @query = params[:query]
    @order = params[:order]
    @people = Person.text_search(params[:query], params[:order]).page(params[:page]).per(15)
    authorize @people
  end

  def show
    @participations = @person.participations
  end

  def new
    @person = Person.new
    authorize @person
    @person.phone_numbers.build
    @person.addresses.build
  end

  def edit
    if @person.addresses.empty?
      @person.addresses.build
    end
    if @person.phone_numbers.empty?
      @person.phone_numbers.build
    end

    session[:last_page] = request.referrer || person_path(@person)
  end

  def create
    @person = Person.new secure_params
    authorize @person

    if @person.save
      redirect_to person_path(@person)
    else
      render 'new'
    end
  end

  def update
    if @person.update(secure_params)
      redirect_to session[:last_page] || person_path(@person)
    else
      render 'edit'
    end
  end

  def destroy
    @participations = @person.participations
    if @participations.any?
      flash.now[:alert] = 'Esta pessoa tem participação em eventos portanto não pode ser deletada'
      render 'show'
    elsif @tmks.any?
      flash.now[:alert] = 'Esta pessoa tem contatos TMKs portanto não pode ser deletada'
      render 'show'
    else
      @person.destroy
      redirect_to people_path(page: params[:page], query: params[:query], order: params[:order])
    end
  end

  def versions

    sql = "(item_type='Person' AND item_id=#{@person.id})"

    @person.phone_numbers.each do |pn|
      sql += " OR (item_type='PhoneNumber' AND item_id=#{pn.id})"
    end
    @person.addresses.each do |ad|
      sql += " OR (item_type='Address' AND item_id=#{ad.id})"
    end

    @versions = PaperTrail::Version.where(sql).order(created_at: :desc).page(params[:page]).per(10)
    authorize @person
  end


  private

    def set_tmks
      @tmks = Tmk.where(with_who: @person).order(:updated_at)
    end

    def set_person
      @person = Person.find params[:id]
      authorize @person
    end

    def secure_params
      params.require(:person).permit(:name, :email, :gender, :date_of_birth, :occupation, :nationality,
                                     :return_to, :marketing, :cpf, :rg, :scholarity,
                                     :original_updated_at,
                                     addresses_attributes: [:id, :label, :line1, :zip, :city, :state,
                                                            :country, :_destroy],
                                     phone_numbers_attributes: [:id, :label, :number, :phone_type,
                                                                :provider, :_destroy])
    end


end
