class RenameFieldTmk < ActiveRecord::Migration
  def change
    rename_column :tmks, :when, :contact_date
  end
end
