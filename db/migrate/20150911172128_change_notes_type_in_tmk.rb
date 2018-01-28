class ChangeNotesTypeInTmk < ActiveRecord::Migration[4.2]
  def change
    change_column :tmks, :notes, :text
  end
end
