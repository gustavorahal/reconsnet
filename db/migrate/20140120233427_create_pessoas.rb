class CreatePessoas < ActiveRecord::Migration
  def change
    create_table :pessoas do |t|
      t.string :nome, null: false
      t.string :sexo, :limit => 1
      t.string :email
      t.date :data_nascimento
      t.string :tel_resid, array: true
      t.string :tel_cel, array: true

      t.timestamps
    end
    add_index :pessoas, :nome, unique: true

  end
end
