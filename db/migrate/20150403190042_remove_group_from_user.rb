class RemoveGroupFromUser < ActiveRecord::Migration[4.2]
  def change
    remove_column :users, :group, :string
  end
end
