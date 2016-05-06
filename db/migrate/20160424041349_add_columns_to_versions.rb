class AddColumnsToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :event_id, :integer
    add_column :versions, :person_id, :integer
    add_column :versions, :activity_id, :integer
  end
end
