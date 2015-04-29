class RemoveGroupFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :group, :string
  end
end
