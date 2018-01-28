class AddRelationshipToPerson < ActiveRecord::Migration[4.2]
  def change
    add_column :people, :relationship, :integer
  end
end
