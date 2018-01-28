class AddAssetTypeToAssets < ActiveRecord::Migration[4.2]
  def change
    add_column :assets, :asset_type, :integer
  end
end
