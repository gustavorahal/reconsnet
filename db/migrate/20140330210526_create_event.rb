class CreateEvent < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :description
      t.string :event_type
      t.datetime :start, null: false
      t.datetime :finish, null: false

      t.timestamps
    end

    add_index :events, :name

  end
end
