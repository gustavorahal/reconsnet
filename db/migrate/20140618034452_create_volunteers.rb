class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.references :person, index: true, null: false
      t.date :admission
      t.string :area_of_operation

      t.timestamps
    end
  end
end
