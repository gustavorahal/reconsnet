class RemoveAvatarFromPeople < ActiveRecord::Migration[5.2]
  def change
    remove_column :people, :avatar_file_name
    remove_column :people, :avatar_content_type
    remove_column :people, :avatar_file_size
    remove_column :people, :avatar_updated_at
  end
end
