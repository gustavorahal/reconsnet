class AddRelationshipToPerson < ActiveRecord::Migration
  def change
    add_column :people, :relationship, :integer
  end
end
