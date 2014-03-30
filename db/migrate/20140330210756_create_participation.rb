class CreateParticipation < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :event, index: true, null: false
      t.references :person, index: true, null: false
      t.string :type, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
