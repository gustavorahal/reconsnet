class TinymceAssetsController < ApplicationController
  def create
    assetable_id, assetable_type = params[:hint].split(',')
    asset = Asset.new(file: params[:file], assetable_id: assetable_id, assetable_type: assetable_type)
    asset.save!

    render json: {
        image: {
            url: asset.file.url
        }
    }, content_type: 'text/html'
  end
end