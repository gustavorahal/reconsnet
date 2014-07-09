class CreateActivity < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name, null: false
      t.string :summary, null: false
      t.text :description
      t.string :activity_type
      t.references :parent
      t.boolean :internal_only, default: false

      t.timestamps
    end
  end
end
