class CreatePerson < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.string :gender
      t.string :email
      t.date :date_of_birth

      t.timestamps
    end

    add_index :people, :name, unique: true

  end
end
