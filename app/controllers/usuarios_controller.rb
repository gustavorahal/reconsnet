
class UsuariosController < ApplicationController

  def index
    @usuarios = Usuario.all
  end


  def edit
    @usuario = Usuario.find(params[:id])
  end


  def update
    @usuario = Usuario.find(params[:id])

    if @usuario.update(params[:usuario].permit(:name, :papel))
      redirect_to usuarios_path, notice: "Usuário '#{@usuario.name}' atualizado com sucesso!"
    else
      render 'edit'
    end
  end

  def destroy
    @usuario = Usuario.find(params[:id])
    name = @usuario.name
    @usuario.destroy
    redirect_to usuarios_path, notice: "Usuário '#{name}' deletado com sucesso!"
  end

end