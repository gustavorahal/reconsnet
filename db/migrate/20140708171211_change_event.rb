class ChangeEvent < ActiveRecord::Migration
  def change
    remove_column :events, :event_type, :string
    add_reference :events, :activity
  end
end
