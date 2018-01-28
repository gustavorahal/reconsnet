class AddAttachmentAvatarToActivities < ActiveRecord::Migration[4.2]
  def self.up
    change_table :activities do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :activities, :avatar
  end
end
