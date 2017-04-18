class RenameAssetsTable < ActiveRecord::Migration
  def change
    rename_table :assets, :resource_assets
  end
end
