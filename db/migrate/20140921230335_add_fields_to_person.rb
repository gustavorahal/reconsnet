class AddFieldsToPerson < ActiveRecord::Migration[4.2]
  def change
    add_column :people, :cpf, :string
    add_column :people, :rg, :string
    add_column :people, :scholarity, :string
  end
end
