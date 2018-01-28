class AddAttendanceToParticipation < ActiveRecord::Migration[4.2]
  def change
    add_column :participations, :attendance, :integer
  end
end
