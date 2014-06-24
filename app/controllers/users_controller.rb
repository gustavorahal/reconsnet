class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: [:show]


  def index
    @users = User.all
    authorize @users
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(secure_params)
      redirect_to users_path, notice: 'Usuário atualizado!'
    else
      redirect_to users_path, alert:  'Erro atualizando o usuário'
    end
  end


  def destroy
    if @user == current_user
      redirect_to users_path, alert: 'Não pode deletar a si mesmo'
    else
      @user.destroy
      redirect_to users_path, notice: 'Usuário deletado'
    end
  end


  private

    def set_user
      @user = User.find params[:id]
      authorize @user
    end

    def secure_params
      params.require(:user).permit(:role, :person_id)
    end

end
