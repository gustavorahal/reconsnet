class CreateEventos < ActiveRecord::Migration
  def change
    create_table :eventos do |t|
      t.string :nome, null: false
      t.string :descricao
      t.string :tipo
      t.datetime :inicio, null: false
      t.datetime :fim, null: false

      t.timestamps
    end

    add_index :eventos, :nome

  end
end
