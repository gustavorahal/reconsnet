class CreateTmk < ActiveRecord::Migration
  def change
    create_table :tmks do |t|
      t.references :with_who, references: :people, index: true, null: false
      t.references :from_who, references: :people, index: true, null: false
      t.references :event, index: true, null: false
      t.datetime :when
      t.string :contact_type
      t.string :notes

      t.timestamps
    end
  end
end
