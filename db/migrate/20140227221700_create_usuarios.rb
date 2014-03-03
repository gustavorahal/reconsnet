class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nome
      t.string :uid
      t.string :provider

      t.timestamps
    end
  end
end
