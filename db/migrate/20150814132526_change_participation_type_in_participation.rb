class ChangeParticipationTypeInParticipation < ActiveRecord::Migration
  def change
    connection.execute(%q{
  ALTER TABLE participations ALTER COLUMN participation_type TYPE integer USING (participation_type::integer);
})

    rename_column :participations, :participation_type, :p_type
  end
end
