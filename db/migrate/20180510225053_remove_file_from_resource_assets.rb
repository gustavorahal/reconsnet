class RemoveFileFromResourceAssets < ActiveRecord::Migration[5.2]
  def change
    remove_column :resource_assets, :file_file_name
    remove_column :resource_assets, :file_content_type
    remove_column :resource_assets, :file_file_size
    remove_column :resource_assets, :file_updated_at
  end
end
