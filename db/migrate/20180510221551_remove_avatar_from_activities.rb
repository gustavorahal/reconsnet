class RemoveAvatarFromActivities < ActiveRecord::Migration[5.2]
  def change
    remove_column :activities, :avatar_file_name
    remove_column :activities, :avatar_content_type
    remove_column :activities, :avatar_file_size
    remove_column :activities, :avatar_updated_at
  end
end
