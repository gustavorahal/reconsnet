class AssetsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_asset, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def new
    @asset = Asset.new
    authorize @asset
    @assetable = get_assetable
  end

  def edit
  end

  def create
    @asset = Asset.new(secure_params)
    authorize @asset
    @assetable = get_assetable
    @asset.assetable_id = @assetable.id
    @asset.assetable_type = @assetable.class.name

    if @asset.save
      redirect_to polymorphic_path(@assetable)
    else
      render 'new'
    end
  end

  def update
    if @asset.update(secure_params)
      redirect_to polymorphic_path(@assetable)
    else
      render 'edit'
    end
  end

  def destroy
    @asset.destroy
    redirect_to polymorphic_path(@assetable)
  end

  private

    def get_assetable
      model = params[:assetable_type].constantize
      model.find params[:assetable_id]
    end

    def set_asset
      @asset = Asset.find params[:id]
      authorize @asset
      @assetable = get_assetable
    end

    def secure_params
      params.require(:asset).permit(:name, :description, :file, :assetable_type, :assetable_id)
    end

end