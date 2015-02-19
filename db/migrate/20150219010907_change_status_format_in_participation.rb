class ChangeStatusFormatInParticipation < ActiveRecord::Migration
  def change
    connection.execute(%q{
  ALTER TABLE participations ALTER COLUMN status TYPE integer USING (status::integer);
})

  end
end
