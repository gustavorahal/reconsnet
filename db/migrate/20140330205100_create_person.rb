class CreatePerson < ActiveRecord::Migration[4.2]
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.string :gender
      t.string :email
      t.date :date_of_birth
      t.string :occupation
      t.string :nationality
      t.boolean :marketing, default: true

      t.timestamps
    end

    add_index :people, :name, unique: true

  end
end
