class AddAssetTypeToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :asset_type, :integer
  end
end
