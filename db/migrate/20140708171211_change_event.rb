class ChangeEvent < ActiveRecord::Migration[4.2]
  def change
    remove_column :events, :event_type, :string
    add_reference :events, :activity
  end
end
