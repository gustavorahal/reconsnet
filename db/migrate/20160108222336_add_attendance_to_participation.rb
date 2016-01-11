class AddAttendanceToParticipation < ActiveRecord::Migration
  def change
    add_column :participations, :attendance, :integer
  end
end
