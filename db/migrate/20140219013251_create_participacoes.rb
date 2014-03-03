class CreateParticipacoes < ActiveRecord::Migration
  def change
    create_table :participacoes do |t|
      t.references :evento, index: true, null: false
      t.references :pessoa, index: true, null: false
      t.string :tipo, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
