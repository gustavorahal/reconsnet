class PeopleController < ApplicationController

  def index
    @query = params[:query]
    @people = Person.text_search(params[:query]).order('LOWER(name)').page(params[:page]).per(15)
  end

  def new
    @person = Person.new
    @person.phone_numbers.build
    @person.addresses.build
  end

  def create
    @person = Person.new secure_params

    if @person.save
      redirect_to person_path(@person)
    else
      render 'new'
    end

  end

  def update
    @person = Person.find params[:id]

    if @person.update(secure_params)
      redirect_to session[:last_page] || @person
    else
      render 'edit'
    end

  end

  def edit
    @person = Person.find params[:id]
    if @person.addresses.empty?
      @person.addresses.build
    end
    if @person.phone_numbers.empty?
      2.times { @person.phone_numbers.build }
    end

    session[:last_page] = request.env['HTTP_X_XHR_REFERER']
  end

  def show
    @person = Person.find params[:id]
    @participations = @person.participations
  end

  def destroy
    @person = Person.find params[:id]
    @participations = @person.participations
    if @participations.any?
      flash.now[:alert] = 'Esta pessoa tem participação em eventos portanto não pode ser deletada'
      render 'show'
    else
      @person.destroy
      redirect_to people_path(page: params[:page])
    end

  end

  private

  def secure_params
    params.require(:person).permit(:name, :email, :gender, :date_of_birth, :occupation, :nationality,
                                   :return_to,
                                   :original_updated_at,
                                   addresses_attributes: [:id, :label, :line1, :zip, :city, :state_code,
                                                          :country_code, :_destroy],
                                   phone_numbers_attributes: [:id, :label, :number, :phone_type,
                                                              :provider, :_destroy])
  end


end
