class ResourceAssetsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_asset, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  def new
    @resource_asset = ResourceAsset.new
    authorize @resource_asset
    @assetable = get_assetable
  end

  def edit
  end

  def create
    @resource_asset = ResourceAsset.new(secure_params)
    authorize @resource_asset
    @assetable = get_assetable
    @resource_asset.assetable_id = @assetable.id
    @resource_asset.assetable_type = @assetable.class.name

    if @resource_asset.save
      redirect_to polymorphic_path(@assetable)
    else
      render 'new'
    end
  end

  def update
    if @resource_asset.update(secure_params)
      redirect_to polymorphic_path(@assetable)
    else
      render 'edit'
    end
  end

  def destroy
    @resource_asset.destroy
    redirect_to polymorphic_path(@assetable)
  end

  private

    def get_assetable
      model = params[:assetable_type].constantize
      model.find params[:assetable_id]
    end

    def set_asset
      @resource_asset = ResourceAsset.find params[:id]
      authorize @resource_asset
      @assetable = get_assetable
    end

    def secure_params
      params.require(:resource_asset).permit(:file, :asset_type, :assetable_type, :assetable_id)
    end

end