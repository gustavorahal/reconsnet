class CreateEventoPessoas < ActiveRecord::Migration
  def change
    create_table :evento_pessoas do |t|
      t.references :evento, index: true, null: false
      t.references :pessoa, index: true, null: false
      t.string :tipo_participacao, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
