class ChangeSummaryTypeInActivity < ActiveRecord::Migration
  def change
    change_column :activities, :summary, :text
  end
end
