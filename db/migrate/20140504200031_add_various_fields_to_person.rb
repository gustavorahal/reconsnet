class AddVariousFieldsToPerson < ActiveRecord::Migration
  def change

    enable_extension 'hstore'

    change_table(:people) do |t|
      t.string :occupation
      t.string :nationality
      t.boolean :marketing
      t.hstore :marketing_optout
    end

  end
end
