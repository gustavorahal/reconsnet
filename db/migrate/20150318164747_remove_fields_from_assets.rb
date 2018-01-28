class RemoveFieldsFromAssets < ActiveRecord::Migration[4.2]
  def change
    remove_column :assets, :name, :string
    remove_column :assets, :description, :string
  end
end
