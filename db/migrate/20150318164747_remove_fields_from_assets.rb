class RemoveFieldsFromAssets < ActiveRecord::Migration
  def change
    remove_column :assets, :name, :string
    remove_column :assets, :description, :string
  end
end
