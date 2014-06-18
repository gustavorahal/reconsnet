class CreateAddress < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :label
      t.string :line1
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps
    end

    add_index :addresses, [:addressable_type, :addressable_id]
  end
end
