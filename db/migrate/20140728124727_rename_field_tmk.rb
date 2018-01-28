class RenameFieldTmk < ActiveRecord::Migration[4.2]
  def change
    rename_column :tmks, :when, :contact_date
  end
end
