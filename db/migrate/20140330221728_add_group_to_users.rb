class AddGroupToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :group, :string
  end
end
