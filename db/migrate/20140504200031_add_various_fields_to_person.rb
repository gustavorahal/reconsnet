class AddVariousFieldsToPerson < ActiveRecord::Migration
  def change

    enable_extension 'hstore'

    change_table(:people) do |t|
      t.string :profession
      t.string :nationality
      t.references :address
      t.string :landline_number
      t.string :mobile_number
      t.boolean :marketing
      t.hstore :marketing_optout
    end

  end
end
