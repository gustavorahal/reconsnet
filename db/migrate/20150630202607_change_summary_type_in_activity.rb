class ChangeSummaryTypeInActivity < ActiveRecord::Migration[4.2]
  def change
    change_column :activities, :summary, :text
  end
end
