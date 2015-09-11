class ChangeNotesTypeInTmk < ActiveRecord::Migration
  def change
    change_column :tmks, :notes, :text
  end
end
