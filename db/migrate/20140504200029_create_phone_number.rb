class CreatePhoneNumber < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.string :label
      t.string :number, :null => false
      t.string :provider
      t.string :phone_type, :null => false

      t.integer :phonable_id
      t.string :phonable_type

      t.timestamps
    end

    add_index :phone_numbers, [:phonable_type, :phonable_id]
  end
end
